# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/scipy/scipy-0.10.1.ebuild,v 1.6 2012/10/16 19:47:58 jlec Exp $

EAPI=4

PYTHON_DEPEND="*::3.2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.3 *-jython *-pypy-*"

inherit eutils fortran-2 distutils flag-o-matic toolchain-funcs

DESCRIPTION="Scientific algorithms library for Python"
HOMEPAGE="http://www.scipy.org/ http://pypi.python.org/pypi/scipy"
SRC_URI="
	mirror://sourceforge/${PN}/${P}.tar.gz
	doc? (
		http://docs.scipy.org/doc/${P}/${PN}-html.zip -> ${P}-html.zip
		http://docs.scipy.org/doc/${P}/${PN}-ref.pdf -> ${P}-ref.pdf
	)"

LICENSE="BSD LGPL-2"
SLOT="0"
IUSE="doc test umfpack"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"

CDEPEND="
	dev-python/numpy
	sci-libs/arpack
	virtual/cblas
	virtual/lapack
	umfpack? ( sci-libs/umfpack )"
DEPEND="${CDEPEND}
	virtual/pkgconfig
	doc? ( app-arch/unzip )
	test? ( dev-python/nose )
	umfpack? ( dev-lang/swig )"

RDEPEND="${CDEPEND}
	dev-python/imaging"

DOCS="THANKS.txt LATEST.txt TOCHANGE.txt"

pkg_setup() {
	fortran-2_pkg_setup
	# scipy automatically detects libraries by default
	export {FFTW,FFTW3,UMFPACK}=None
	use umfpack && unset UMFPACK
	# the missing symbols are in -lpythonX.Y, but since the version can
	# differ, we just introduce the same scaryness as on Linux/ELF
	[[ ${CHOST} == *-darwin* ]] \
		&& append-ldflags -bundle "-undefined dynamic_lookup" \
		|| append-ldflags -shared
	[[ -z ${FC}  ]] && export FC="$(tc-getFC)"
	# hack to force F77 to be FC until bug #278772 is fixed
	[[ -z ${F77} ]] && export F77="$(tc-getFC)"
	export F90="${FC}"
	export SCIPY_FCONFIG="config_fc --noopt --noarch"
	append-fflags -fPIC
	python_pkg_setup
}

src_unpack() {
	unpack ${P}.tar.gz
	if use doc; then
		unzip -qo "${DISTDIR}"/${P}-html.zip -d html || die
	fi
}

pc_incdir() {
	pkg-config --cflags-only-I $@ | \
		sed -e 's/^-I//' -e 's/[ ]*-I/:/g'
}

pc_libdir() {
	pkg-config --libs-only-L $@ | \
		sed -e 's/^-L//' -e 's/[ ]*-L/:/g'
}

pc_libs() {
	pkg-config --libs-only-l $@ | \
		sed -e 's/[ ]-l*\(pthread\|m\)[ ]*//g' \
		-e 's/^-l//' -e 's/[ ]*-l/,/g'
}

src_prepare() {
	local libdir="${EPREFIX}"/usr/$(get_libdir)
	cat >> site.cfg <<-EOF
		[blas]
		include_dirs = $(pc_incdir cblas)
		library_dirs = $(pc_libdir cblas blas):${libdir}
		blas_libs = $(pc_libs cblas blas)
		[lapack]
		library_dirs = $(pc_libdir lapack):${libdir}
		lapack_libs = $(pc_libs lapack)
	EOF
}

src_compile() {
	distutils_src_compile ${SCIPY_FCONFIG}
}

src_test() {
	testing() {
		"$(PYTHON)" setup.py build -b "build-${PYTHON_ABI}" install \
			--home="${S}/test-${PYTHON_ABI}" --no-compile ${SCIPY_FCONFIG} \
			|| die "install test failed"
		pushd "${S}/test-${PYTHON_ABI}/"lib*/python > /dev/null
		PYTHONPATH=. "$(PYTHON)" -c "import scipy; scipy.test('full')" \
			2>&1 | tee test.log
		grep -q ^ERROR test.log && die "test failed"
		popd > /dev/null
		rm -fr test-${PYTHON_ABI}
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install ${SCIPY_FCONFIG}
	use doc && dohtml -r "${WORKDIR}"/html/* && dodoc "${DISTDIR}"/${P}*pdf
}

pkg_postinst() {
	distutils_pkg_postinst
	elog "You might want to set the variable SCIPY_PIL_IMAGE_VIEWER"
	elog "to your prefered image viewer if you don't like the default one. Ex:"
	elog "\t echo \"export SCIPY_PIL_IMAGE_VIEWER=display\" >> ~/.bashrc"
}
