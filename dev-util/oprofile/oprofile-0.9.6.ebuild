# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/oprofile/oprofile-0.9.6.ebuild,v 1.9 2012/06/07 21:41:19 zmedico Exp $

EAPI=1
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

pkg_setup() {
	linux-info_pkg_setup
	if ! linux_config_exists || ! linux_chkconfig_present OPROFILE; then
		elog "In order for oprofile to work, you need to configure your kernel"
		elog "with CONFIG_OPROFILE set to 'm' or 'y'."
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/oprofile-0.9.6-mutable.patch
}

src_compile() {
	local myconf="--with-qt-dir=/void --with-x"

	case ${KV_FULL} in
	2.2.*|2.4.*) myconf="${myconf} --with-linux=${KV_DIR}";;
	2.5.*|2.6.*) myconf="${myconf} --with-kernel-support";;
	*) die "Kernel version '${KV_FULL}' not supported";;
	esac
	econf ${myconf} || die

	local mymake=""

	sed -i -e "s,depmod -a,:,g" Makefile
	emake ${mymake} || die
}

src_install() {
	local myinst=""

	myinst="${myinst} MODINSTALLDIR=${D}/lib/modules/${KV_FULL}"
	make DESTDIR="${D}" ${myinst} htmldir="/usr/share/doc/${PF}" install || die

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
