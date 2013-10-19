# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/scipy/scipy-0.12.1.ebuild,v 1.2 2013/10/19 19:46:29 ago Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit eutils fortran-2 distutils-r1 flag-o-matic multilib toolchain-funcs

DESCRIPTION="Scientific algorithms library for Python"
HOMEPAGE="http://www.scipy.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	doc? (
		http://docs.scipy.org/doc/${PN}/${PN}-html.zip -> ${P}-html.zip
		http://docs.scipy.org/doc/${PN}/${PN}-ref.pdf -> ${P}-ref.pdf
	)"

LICENSE="BSD LGPL-2"
SLOT="0"
IUSE="doc sparse test"
KEYWORDS="amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"

CDEPEND="
	dev-python/numpy[lapack,${PYTHON_USEDEP}]
	sci-libs/arpack
	virtual/cblas
	virtual/lapack
	sparse? ( sci-libs/umfpack )"
DEPEND="${CDEPEND}
	dev-lang/swig
	dev-python/cython[${PYTHON_USEDEP}]
	virtual/pkgconfig
	doc? ( app-arch/unzip )
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

RDEPEND="${CDEPEND}
	virtual/python-imaging[${PYTHON_USEDEP}]"

DOCS=( HACKING.rst.txt README.txt THANKS.txt LATEST.txt TOCHANGE.txt )

DISTUTILS_IN_SOURCE_BUILD=1

src_unpack() {
	unpack ${P}.tar.gz
	if use doc; then
		unzip -qo "${DISTDIR}"/${P}-html.zip -d html || die
	fi
}

pc_incdir() {
	$(tc-getPKG_CONFIG) --cflags-only-I $@ | \
		sed -e 's/^-I//' -e 's/[ ]*-I/:/g' -e 's/[ ]*$//'
}

pc_libdir() {
	$(tc-getPKG_CONFIG) --libs-only-L $@ | \
		sed -e 's/^-L//' -e 's/[ ]*-L/:/g' -e 's/[ ]*$//'
}

pc_libs() {
	$(tc-getPKG_CONFIG) --libs-only-l $@ | \
		sed -e 's/[ ]-l*\(pthread\|m\)[ ]*//g' \
		-e 's/^-l//' -e 's/[ ]*-l/,/g' -e 's/[ ]*$//'
}

python_prepare_all() {
	# scipy automatically detects libraries by default
	export {FFTW,FFTW3,UMFPACK}=None
	use sparse && unset UMFPACK
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

	local PATCHES=(
		"${FILESDIR}"/${PN}-0.12.0-gerqf.patch
		"${FILESDIR}"/${PN}-0.12.0-blitz.patch
		"${FILESDIR}"/${PN}-0.12.0-restore-sys-argv.patch
		"${FILESDIR}"/${PN}-0.12.0-cephes-missing-include.patch
	)
	distutils-r1_python_prepare_all
}

python_compile() {
	distutils-r1_python_compile ${SCIPY_FCONFIG}
}

python_test() {
	distutils_install_for_testing ${SCIPY_FCONFIG}
	cd "${TEST_DIR}" || die "no ${TEST_DIR} available"
	# nasty hack to remove weave tests because it is not python3 compat
	[[ ${TEST_DIR} =~ python3 ]] && rm -r "${TEST_DIR}"/lib/scipy/weave
#r = scipy.test('full', verbose=10)
	"${EPYTHON}" -c "
import scipy, sys
r = scipy.test('fast',verbose=2)
sys.exit(0 if r.wasSuccessful() else 1)" || die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	if use doc; then
		dohtml -r "${WORKDIR}"/html/.
		dodoc "${DISTDIR}"/${P}*pdf
	fi
	distutils-r1_python_install_all
}

python_install() {
	distutils-r1_python_install ${SCIPY_FCONFIG}
}

pkg_postinst() {
	elog "You might want to set the variable SCIPY_PIL_IMAGE_VIEWER"
	elog "to your prefered image viewer. Example:"
	elog "\t echo \"export SCIPY_PIL_IMAGE_VIEWER=display\" >> ~/.bashrc"
}
