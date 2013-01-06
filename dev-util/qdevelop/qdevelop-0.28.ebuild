# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/qdevelop/qdevelop-0.28.ebuild,v 1.6 2012/02/02 16:03:23 ago Exp $

EAPI=4

inherit eutils cmake-utils

MY_P=${PN}-v${PV}
DESCRIPTION="A development environment entirely dedicated to Qt4."
HOMEPAGE="http://biord-software.org/qdevelop/"
SRC_URI="http://biord-software.org/downloads/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="amd64 x86"
SLOT="0"
IUSE="debug plugins"

DEPEND="x11-libs/qt-gui:4
	x11-libs/qt-sql:4[sqlite]"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

PATCHES=( "${FILESDIR}"/${P}-qt-4.7_fix.patch )

src_configure() {
	mycmakeargs=( "-DAUTOPLUGINS=$(use plugins && echo 1 || echo 0)" )

	sed -e "s#/lib/pkgconfig#/$(get_libdir)/pkgconfig#" \
		-e "s#DESTINATION lib#DESTINATION $(get_libdir)#" \
	    -i CMakeLists.txt || die "sed fixing multilib failed"

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	dodoc ChangeLog.txt README.txt
	newicon "${S}"/resources/images/QDevelop.png qdevelop.png
	make_desktop_entry ${PN}
}

pkg_postinst(){
	elog "Additional functionality can be achieved by emerging other packages:"
	elog "  dev-util/ctags - code completion"
	elog "  sys-devel/gdb - debugging"
}
