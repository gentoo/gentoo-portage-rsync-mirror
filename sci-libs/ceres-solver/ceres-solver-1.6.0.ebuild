# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/ceres-solver/ceres-solver-1.6.0.ebuild,v 1.1 2013/05/22 21:10:26 bicatali Exp $

EAPI=5

inherit cmake-utils eutils multilib toolchain-funcs

DESCRIPTION="Nonlinear least-squares minimizer"
HOMEPAGE="https://code.google.com/p/ceres-solver/"
SRC_URI="https://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc examples gflags metis openmp protobuf +schur +sparse static-libs test"
REQUIRED_USE="test? ( gflags )"

RDEPEND="
	dev-cpp/eigen:3
	dev-cpp/glog[gflags?]
	protobuf? ( dev-libs/protobuf )
	sparse? (
		sci-libs/amd
		sci-libs/camd
		sci-libs/ccolamd
		sci-libs/cholmod[metis?]
		sci-libs/colamd
		sci-libs/cxsparse
		virtual/blas
		virtual/lapack )"
DEPEND="${RDEPEND}
	sparse? ( virtual/pkgconfig )
	doc? ( dev-python/sphinx )"

src_prepare() {
	# prefix love
	# disable blas/lapack forced library names
	sed -i \
		-e "s:/usr:${EPREFIX}/usr:g" \
		-e '/FIND_LIBRARY(BLAS_LIB NAMES blas)/d' \
		-e '/FIND_LIBRARY(LAPACK_LIB NAMES lapack)/d' \
		-e 's/EXISTS ${BLAS_LIB}/BLAS_LIB/g' \
		-e 's/EXISTS ${LAPACK_LIB}/LAPACK_LIB/g' \
		-e 's/-Werror//g' \
		CMakeLists.txt || die

	# respect gentoo doc dir
	sed -i \
		-e "s:share/doc/ceres:share/doc/${PF}:" \
		docs/source/CMakeLists.txt || die
}

src_configure() {
	local blibs llibs
	if use sparse; then
		blibs=$($(tc-getPKG_CONFIG) --libs blas)
		llibs=$($(tc-getPKG_CONFIG) --libs lapack)
	fi
	local mycmakeargs=(
		-DBLAS_LIB="${blibs}"
		-DLAPACK_LIB="${llibs}"
		$(cmake-utils_use_enable test TESTING)
		$(cmake-utils_use doc BUILD_DOCUMENTATION)
		$(cmake-utils_use gflags GFLAGS)
		$(cmake-utils_use openmp OPENMP)
		$(cmake-utils_use protobuf PROTOBUF)
		$(cmake-utils_use schur SCHUR_SPECIALIZATIONS)
		$(cmake-utils_use sparse CXSPARSE)
		$(cmake-utils_use sparse SUITESPARSE)
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	dodoc README VERSION

	use static-libs || rm "${ED}"/usr/$(get_libdir)/libceres.a
	dosym libceres_shared.so /usr/$(get_libdir)/libceres.so

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
