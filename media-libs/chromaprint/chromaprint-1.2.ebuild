# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/chromaprint/chromaprint-1.2.ebuild,v 1.2 2014/11/20 17:07:44 klausman Exp $

EAPI=5
inherit cmake-utils

DESCRIPTION="A client-side library that implements a custom algorithm for extracting fingerprints"
HOMEPAGE="http://acoustid.org/chromaprint"
SRC_URI="https://bitbucket.org/acoustid/${PN}/downloads/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~x86 ~amd64-fbsd"
IUSE="test tools"

# note: use ffmpeg instead of fftw because it's recommended and required for tools
RDEPEND=">=virtual/ffmpeg-0.10"
DEPEND="${RDEPEND}
	test? (
		dev-cpp/gtest
		dev-libs/boost
	)"

DOCS="NEWS.txt README.md"

PATCHES=( "${FILESDIR}"/${PN}-1.1-gtest.patch )

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_build tools EXAMPLES)
		$(cmake-utils_use_build test TESTS)
		-DWITH_AVFFT=ON
		)
	cmake-utils_src_configure
}

src_test() {
	cd "${BUILD_DIR}" || die
	emake check
}

src_install() {
	cmake-utils_src_install
}
