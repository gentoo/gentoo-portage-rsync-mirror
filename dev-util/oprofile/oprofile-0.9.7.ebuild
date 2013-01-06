# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/oprofile/oprofile-0.9.7.ebuild,v 1.5 2012/10/20 22:49:11 slyfox Exp $

EAPI=2
inherit eutils linux-info multilib user java-pkg-opt-2

MY_P=${PN}-${PV/_/-}
DESCRIPTION="A transparent low-overhead system-wide profiler"
HOMEPAGE="http://oprofile.sourceforge.net"
SRC_URI="mirror://sourceforge/oprofile/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="java pch qt4"

DEPEND=">=dev-libs/popt-1.7-r1
	>=sys-devel/binutils-2.14.90.0.6-r3
	>=sys-libs/glibc-2.3.2-r1
	qt4? ( x11-libs/qt-gui:4[qt3support] )
	java? ( >=virtual/jdk-1.5 )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	linux-info_pkg_setup
	if ! linux_config_exists || ! linux_chkconfig_present OPROFILE; then
		elog "In order for oprofile to work, you need to configure your kernel"
		elog "with CONFIG_OPROFILE set to 'm' or 'y'."
	fi

	# Required for JIT support, see README_PACKAGERS
	enewgroup oprofile
	enewuser oprofile -1 -1 -1 oprofile

	#sed -i -e "s/depmod -a/:/g" Makefile.in

	use java && java-pkg_init
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-bfd.h-{1,2}.patch # bug 428506
}

src_configure() {
	econf \
		--with-kernel-support \
		$(use_with qt4 x) \
		$(use_enable qt4 gui qt4) \
		$(use_enable pch) \
		$(use_with java java ${JAVA_HOME})
}

src_install() {
	emake DESTDIR="${D}" htmldir="/usr/share/doc/${PF}" install || die

	dodoc ChangeLog* README TODO

	dodir /etc/env.d
	echo "LDPATH=${PREFIX}/usr/$(get_libdir)/oprofile" > "${D}"/etc/env.d/10${PN} || die "env.d failed"
}

pkg_postinst() {
	echo
	elog "Now load the oprofile module by running:"
	elog "  # opcontrol --init"
	elog "Then read manpages and this html doc:"
	elog "  /usr/share/doc/${PF}/oprofile.html"
	echo
}
