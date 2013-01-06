# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/oprofile/oprofile-0.9.6-r1.ebuild,v 1.7 2011/06/23 21:18:52 jer Exp $

EAPI=4
inherit eutils linux-info

DESCRIPTION="A transparent low-overhead system-wide profiler"
HOMEPAGE="http://oprofile.sourceforge.net"
SRC_URI="mirror://sourceforge/oprofile/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ppc ~ppc64 ~sparc x86"
IUSE=""

DEPEND=">=dev-libs/popt-1.7-r1
	>=sys-devel/binutils-2.14.90.0.6-r3
	>=sys-libs/glibc-2.3.2-r1"
RDEPEND="${DEPEND}"

pkg_setup() {
	linux-info_pkg_setup
	if ! linux_config_exists || ! linux_chkconfig_present OPROFILE; then
		elog "In order for oprofile to work, you need to configure your kernel"
		elog "with CONFIG_OPROFILE set to 'm' or 'y'."
	fi
}

src_prepare() {
	epatch "${FILESDIR}/${P}-mutable.patch"
	epatch "${FILESDIR}/${P}-Ensure-that-save-only-saves-things-in-SESSION_DIR.patch"
	epatch "${FILESDIR}/${P}-Fix-opcontrol-status-to-show-accurate-information.patch"
	epatch "${FILESDIR}/${P}-Avoid-blindly-source-SETUP_FILE-with.patch"
	epatch "${FILESDIR}/${P}-Add-argument-checking-for-numerical-arguments.patch"
	epatch "${FILESDIR}/${P}-Avoid-using-bash.patch"
	epatch "${FILESDIR}/${P}-Do-additional-checks-on-user-supplied-arguments.patch"
}

src_configure() {
	local myconf="--with-qt-dir=/void --with-x"

	case ${KV_FULL} in
	2.2.*|2.4.*) myconf="${myconf} --with-linux=${KV_DIR}";;
	2.5.*|2.6.*|3.*) myconf="${myconf} --with-kernel-support";;
	*) die "Kernel version '${KV_FULL}' not supported";;
	esac
	econf ${myconf}
}

src_compile() {
	local mymake=""
	sed -i -e "s,depmod -a,:,g" Makefile || die
	emake ${mymake}
}

src_install() {
	local myinst=""

	myinst="${myinst} MODINSTALLDIR=${ED}/lib/modules/${KV_FULL}"
	emake DESTDIR="${D}" ${myinst} htmldir="/usr/share/doc/${PF}" install

	dodoc ChangeLog* README TODO
}

pkg_postinst() {
	if [[ ${ROOT} == / ]] ; then
		[[ -x /sbin/update-modules ]] && /sbin/update-modules || /sbin/modules-update
	fi

	echo
	elog "Now load the oprofile module by running:"
	elog "  # opcontrol --init"
	elog "Then read manpages and this html doc:"
	elog "  /usr/share/doc/${PF}/oprofile.html"
	echo
}
