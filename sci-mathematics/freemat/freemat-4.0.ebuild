# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/freemat/freemat-4.0.ebuild,v 1.6 2012/05/04 07:46:50 jdhore Exp $

EAPI="2"
inherit eutils cmake-utils fdo-mime

MY_PN=FreeMat
MY_P=${MY_PN}-${PV}

DESCRIPTION="Environment for rapid engineering and scientific processing"
HOMEPAGE="http://freemat.sourceforge.net/"
SRC_URI="mirror://sourceforge/freemat/${MY_P}-Source.tar.gz"

IUSE="volpack"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-libs/libpcre
	media-libs/portaudio
	sci-libs/arpack
	sci-libs/fftw:3.0
	sci-libs/umfpack
	sys-libs/ncurses
	virtual/lapack
	virtual/glu
	virtual/opengl
	x11-libs/qt-gui:4
	x11-libs/qt-opengl:4
	x11-libs/qt-svg:4
	volpack? ( media-libs/volpack )"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}/${MY_P}.1-Source"

src_prepare(){
	epatch \
		"${FILESDIR}"/${P}-gcc45.patch \
		"${FILESDIR}"/${P}-no_implicit_GLU.patch
}

src_configure() {
	rm -f CMakeCache.txt libs/lib*/*.moc.* src/*.moc.*
	mycmakeargs="${mycmakeargs}
		-DUSE_LLVM=OFF
		-DFORCE_BUNDLED_PCRE=OFF
		-DFORCE_BUNDLED_UMFPACK=OFF
		-DFORCE_BUNDLED_PORTAUDIO=OFF
		-DFORCE_BUNDLED_ZLIB=OFF
		-DFORCE_BUNDLED_AMD=OFF
		$(cmake-utils_use_with volpack VOLPACK)"
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	dodoc ChangeLog || die "dodoc failed"
	newicon images/freemat_small_mod_64.png ${PN}.png
	make_desktop_entry FreeMat FreeMat
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	elog "Before using ${MY_PN}, do (as a normal user)"
	elog "FreeMat -i /usr/share/${MY_P}"
	elog "Then start ${MY_PN}, choose Tools -> Path Tool,"
	elog "select /usr/share/${MY_P}/toolbox and Add With Subfolders"
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
