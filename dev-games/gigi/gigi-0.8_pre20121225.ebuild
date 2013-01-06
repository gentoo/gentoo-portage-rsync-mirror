# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/gigi/gigi-0.8_pre20121225.ebuild,v 1.1 2012/12/25 20:25:18 tomka Exp $

EAPI=4

PYTHON_DEPEND="2"

inherit cmake-utils eutils python

DESCRIPTION="An OpenGL interface library"
HOMEPAGE="http://gigi.sourceforge.net"
SRC_URI="http://dev.gentoo.org/~tomka/files/${PF}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="devil doc eve ogre ois sdl static-libs threads"
RESTRICT="test" # fails for unknown reasons

RDEPEND="
	>=dev-libs/boost-1.47
	media-libs/freetype:2
	sys-devel/libtool
	sys-libs/zlib
	x11-libs/libX11
	virtual/opengl
	devil? ( >=media-libs/devil-1.6.1 )
	!devil? (
		media-libs/libpng:0
		media-libs/tiff:0
		virtual/jpeg
	)
	ogre? (
		>=dev-games/ogre-1.7.4[ois?]
		ois? ( dev-games/ois )
	)
	sdl? ( media-libs/libsdl )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( app-doc/doxygen )"
REQUIRED_USE="ois? ( ogre )"

CMAKE_USE_DIR="${S}"

# For segfaults during compile see  https://qa.mandriva.com/show_bug.cgi?id=62558"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.8_pre20120910-docdir.patch

	# use systems ltdl
	rm -r "${CMAKE_USE_DIR}"/libltdl || die
	epatch "${FILESDIR}"/${PN}-0.8_pre20120910-libtool.patch

	# fix devil (apply after libtool.patch)
	epatch "${FILESDIR}"/${PN}-0.8_pre20120910-devil.patch

	python_convert_shebangs 2 GG/gen_signals.py
}

src_configure() {
	# USE_DEVIL broken
	# BUILD_TUTORIALS incomplete
	local mycmakeargs=(
		-DDOCDIR=/usr/share/doc/${PF}/html
		-DRELEASE_COMPILE_FLAGS=""
		$(cmake-utils_use_use devil DEVIL)
		$(cmake-utils_use_build eve EXPERIMENTAL_EVE_SUPPORT)
		$(cmake-utils_use_build ogre OGRE_DRIVER)
		$(cmake-utils_use_build ois OGRE_OIS_PLUGIN)
		$(cmake-utils_use_build sdl SDL_DRIVER)
		$(cmake-utils_use_build doc DOCUMENTATION)
		$(cmake-utils_use_build static-libs STATIC)
		$(cmake-utils_use_build threads MULTI_THREADED)
	)

	cmake-utils_src_configure
}
