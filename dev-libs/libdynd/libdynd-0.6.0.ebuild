# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libdynd/libdynd-0.6.0.ebuild,v 1.1 2014/02/10 23:30:10 bicatali Exp $

EAPI=5

inherit cmake-utils multilib

DESCRIPTION="C++ dynamic multi-dimensionnal array library with Python exposure"
HOMEPAGE="https://github.com/ContinuumIO/libdynd"
SRC_URI="https://github.com/ContinuumIO/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"

IUSE="doc test"

RDEPEND="dev-libs/c-blosc"
DEPEND="${RDEPEND}"

DOCS=( README.md )

PATCHES=(
	"${FILESDIR}"/${P}-out-of-git-versioning.patch
	"${FILESDIR}"/${P}-dont-install-test.patch
	"${FILESDIR}"/${P}-respect-libdir.patch
	"${FILESDIR}"/${P}-optional-cblosc.patch
)

src_configure() {
	sed -i \
		-e '/add_subdirectory(examples)/d' \
		CMakeLists.txt || die
	local mycmakeargs=(
		-DDYND_SHARED_LIB=ON
		-DDYND_INSTALL_LIB=ON
		-DDYND_INTERNAL_BLOSC=OFF
		$(cmake-utils_use test DYND_BUILD_TESTS)
	)
	cmake-utils_src_configure
}

src_test() {
	cd "${BUILD_DIR}" || die
	./tests/test_libdynd || die
}

src_install() {
	cmake-utils_src_install
	use doc && dodoc documents/*
}
