# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/openbabel-python/openbabel-python-2.3.2.ebuild,v 1.3 2013/02/08 12:25:16 ago Exp $

EAPI=5

PYTHON_COMPAT=(python2_6 python2_7 python3_1 python3_2)

inherit cmake-utils eutils multilib python-r1

DESCRIPTION="Python bindings for OpenBabel (including Pybel)"
HOMEPAGE="http://openbabel.sourceforge.net/"
SRC_URI="mirror://sourceforge/openbabel/openbabel-${PV}.tar.gz"

KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

RDEPEND="${PYTHON_DEPS}
	!sci-chemistry/babel
	~sci-chemistry/openbabel-${PV}
	sys-libs/zlib"
DEPEND="${RDEPEND}
	>=dev-util/cmake-2.4.8
	>=dev-lang/swig-2"

S="${WORKDIR}"/openbabel-${PV}

PATCHES=(
	"${FILESDIR}/${P}-testpybel.patch"
	"${FILESDIR}/${P}-bindings_only.patch" )

src_prepare() {
	base_src_prepare
	sed \
		-e "s:\"\.\.\":\"${EPREFIX}/usr\":g" \
		-i test/testbabel.py || die
	swig -python -c++ -small -O -templatereduce -naturalvar \
		-I"${EPREFIX}/usr/include/openbabel-2.0" \
		-o scripts/python/openbabel-python.cpp \
		-DHAVE_EIGEN \
		-outdir scripts/python \
		scripts/openbabel-python.i \
		|| die "Regeneration of openbabel-python.cpp failed"
}

src_configure() {
	my_impl_src_configure() {
		local mycmakeargs="${mycmakeargs}
			-DCMAKE_INSTALL_RPATH=
			-DBINDINGS_ONLY=ON
			-DBABEL_SYSTEM_LIBRARY="${EPREFIX}/usr/$(get_libdir)/libopenbabel.so"
			-DOB_MODULE_PATH="${EPREFIX}/usr/$(get_libdir)/openbabel/${PV}"
			-DLIB_INSTALL_DIR="${ED}/usr/$(get_libdir)/${EPYTHON}/site-packages"
			-DPYTHON_BINDINGS=ON
			-DPYTHON_EXECUTABLE=${PYTHON}
			-DPYTHON_INCLUDE_DIR="${EPREFIX}/usr/include/${EPYTHON}"
			-DPYTHON_LIBRARY="${EPREFIX}/usr/$(get_libdir)/lib${EPYTHON}.so"
			-DENABLE_TESTS=ON"

		cmake-utils_src_configure
	}

	python_foreach_impl my_impl_src_configure
}

src_compile() {
	python_foreach_impl cmake-utils_src_make bindings_python
}

src_test() {
	python_foreach_impl cmake-utils_src_test -R py
}

src_install() {
	my_impl_src_install() {
		cd "${BUILD_DIR}" || die

		cmake -DCOMPONENT=bindings_python -P cmake_install.cmake

		python_optimize
	}

	python_foreach_impl my_impl_src_install
}
