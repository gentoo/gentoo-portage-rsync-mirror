# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/openjpeg/openjpeg-9999.ebuild,v 1.3 2013/06/08 10:36:47 xmw Exp $

EAPI=5
inherit cmake-utils eutils multilib subversion

DESCRIPTION="An open-source JPEG 2000 library"
HOMEPAGE="http://code.google.com/p/openjpeg/"
ESVN_REPO_URI="http://openjpeg.googlecode.com/svn/trunk/"

LICENSE="BSD-2"
SLOT="2"
KEYWORDS=""
IUSE="doc static-libs test +vanilla"

RDEPEND="media-libs/lcms:2=[static-libs?]
	media-libs/libpng:0=[static-libs?]
	media-libs/tiff:0=[static-libs?]
	sys-libs/zlib:=[static-libs?]"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

DOCS=( AUTHORS NEWS README THANKS )

RESTRICT="test" #409263

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-build.patch \
		"${FILESDIR}"/${PN}-2.0.0-pkgconfig-static.patch
	if ! use vanilla ; then
		epatch "${FILESDIR}"/${P}-mupdf.patch
	fi
}

src_configure() {
	local mycmakeargs=(
		-DOPENJPEG_INSTALL_LIB_DIR="$(get_libdir)"
		$(cmake-utils_use_build doc)
		$(cmake-utils_use_build test TESTING)
		)

	cmake-utils_src_configure

	if use static-libs ; then
		mycmakeargs=(
			-DOPENJPEG_INSTALL_LIB_DIR="$(get_libdir)"
			$(cmake-utils_use_build test TESTING)
			-DBUILD_SHARED_LIBS=OFF
			)
		BUILD_DIR=${BUILD_DIR}_static cmake-utils_src_configure
	fi
}

src_compile() {
	cmake-utils_src_compile

	if use static-libs ; then
		BUILD_DIR=${BUILD_DIR}_static cmake-utils_src_compile
	fi
}

src_install() {
	if use static-libs ; then
		BUILD_DIR=${BUILD_DIR}_static cmake-utils_src_install
		#static bins overwritten by shared install
	fi

	cmake-utils_src_install
}
