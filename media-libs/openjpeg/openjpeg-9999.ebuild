# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/openjpeg/openjpeg-9999.ebuild,v 1.1 2013/06/06 21:57:56 xmw Exp $

EAPI=5
inherit cmake-utils multilib subversion

DESCRIPTION="An open-source JPEG 2000 library"
HOMEPAGE="http://code.google.com/p/openjpeg/"
ESVN_REPO_URI="http://openjpeg.googlecode.com/svn/trunk/"

LICENSE="BSD-2"
SLOT="2"
KEYWORDS=""
IUSE="doc test"

RDEPEND="media-libs/lcms:2=
	media-libs/libpng:0=
	media-libs/tiff:0=
	sys-libs/zlib:="
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

DOCS=( AUTHORS NEWS README THANKS )

PATCHES=( "${FILESDIR}"/${P}-build.patch )

RESTRICT="test" #409263

src_configure() {
	local mycmakeargs=(
		-DOPENJPEG_INSTALL_LIB_DIR="$(get_libdir)"
		$(cmake-utils_use_build doc)
		$(cmake-utils_use_build test TESTING)
		)

	cmake-utils_src_configure
}
