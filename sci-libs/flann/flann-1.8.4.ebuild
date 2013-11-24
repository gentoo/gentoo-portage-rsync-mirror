# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/flann/flann-1.8.4.ebuild,v 1.2 2013/11/24 17:02:38 jlec Exp $

EAPI=5

inherit cmake-utils eutils multilib toolchain-funcs

DESCRIPTION="Library for performing fast approximate nearest neighbor searches in high dimensional spaces"
HOMEPAGE="http://www.cs.ubc.ca/~mariusm/index.php/FLANN/FLANN/"
SRC_URI="
	http://people.cs.ubc.ca/~mariusm/uploads/FLANN/${P}-src.zip
	test? ( http://dev.gentoo.org/~bicatali/distfiles/${P}-testdata.tar.xz )"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="cuda doc mpi openmp octave python static-libs test"

RDEPEND="
	sci-libs/hdf5[mpi?]
	mpi? ( dev-libs/boost[mpi] )
	octave? ( sci-mathematics/octave )"
DEPEND="${RDEPEND}
	app-arch/unzip
	test? ( dev-cpp/gtest )"
PDEPEND="python? ( ~dev-python/pyflann-${PV} )"

S="${WORKDIR}"/${P}-src

pkg_setup() {
	if use openmp; then
		if [[ $(tc-getCC) == *gcc ]] && ! tc-has-openmp ; then
			ewarn "OpenMP is not available in your current selected gcc"
			die "need openmp capable gcc"
		fi
	fi
}

src_prepare() {
	# bug #302621
	has_version sci-libs/hdf5[mpi] && export CXX=mpicxx
	# gentoo doc directory respected
	sed -i \
		-e "s:share/doc/flann:share/doc/${PF}:" \
		doc/CMakeLists.txt || die
	# produce pure octave files
	# octave gentoo installation for .m files respected
	sed -i \
		-e 's/--mex//' \
		-e 's/\.mex/\.oct/' \
		-e '/FILES/s/${MEX_FILE}//' \
		-e 's:share/flann/octave:share/octave/site/m:' \
		-e "/CUSTOM_TARGET/a\INSTALL(FILES \${MEX_FILE} DESTINATION libexec/octave/site/oct/${CHOST})" \
		src/matlab/CMakeLists.txt || die
	# do not compile examples by default
	sed -i \
		-e '/add_subdirectory.*examples/d' \
		CMakeLists.txt || die
	# compile tests only when requested
	use test || sed -i -e '/add_subdirectory.*test/d' CMakeLists.txt
	# avoid automatic installation of pdf
	use doc || sed -i -e '/doc/d' CMakeLists.txt
	use cuda && cuda_src_prepare

	sed \
		-e "/FLANN_LIB_INSTALL_DIR/s:lib:$(get_libdir):g" \
		-i cmake/flann_utils.cmake || die
	cmake-utils_src_prepare
}

src_configure() {
	# python bindings are split
	local mycmakeargs=(
		-DBUILD_C_BINDINGS=ON
		-DBUILD_PYTHON_BINDINGS=OFF
		-DPYTHON_EXECUTABLE=
		$(cmake-utils_use_build cuda CUDA_LIB)
		$(cmake-utils_use_build octave MATLAB_BINDINGS)
		$(cmake-utils_use_use mpi)
		$(cmake-utils_use_use openmp)
	)
	cmake-utils_src_configure
}

src_test() {
	ln -s "${WORKDIR}"/testdata/* test/ || die
	# -j1 to avoid obversubscribing jobs
	LD_LIBRARY_PATH="${BUILD_DIR}/lib" \
		cmake-utils_src_compile -j1 test
}

src_install() {
	cmake-utils_src_install
	dodoc README.md
	use static-libs || find "${ED}" -name 'lib*.a' -exec rm -rf '{}' '+'
}
