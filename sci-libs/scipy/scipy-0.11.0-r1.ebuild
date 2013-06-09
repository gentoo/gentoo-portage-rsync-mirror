# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/scipy/scipy-0.11.0-r1.ebuild,v 1.7 2013/06/09 17:58:01 floppym Exp $

EAPI=5

PYTHON_COMPAT=( python{2_5,2_6,2_7} )

inherit eutils fortran-2 distutils-r1 flag-o-matic multilib toolchain-funcs

DESCRIPTION="Scientific algorithms library for Python"
HOMEPAGE="http://www.scipy.org/"
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
	dev-python/numpy[lapack,${PYTHON_USEDEP}]
	sci-libs/arpack
	virtual/cblas
	virtual/lapack
	umfpack? ( sci-libs/umfpack )"
DEPEND="${CDEPEND}
	virtual/pkgconfig
	doc? ( app-arch/unzip )
	test? ( dev-python/nose[${PYTHON_USEDEP}] )
	umfpack? ( dev-lang/swig )"

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
		sed -e 's/^-I//' -e 's/[ ]*-I/:/g'
}

pc_libdir() {
	$(tc-getPKG_CONFIG) --libs-only-L $@ | \
		sed -e 's/^-L//' -e 's/[ ]*-L/:/g'
}

pc_libs() {
	$(tc-getPKG_CONFIG) --libs-only-l $@ | \
		sed -e 's/[ ]-l*\(pthread\|m\)[ ]*//g' \
		-e 's/^-l//' -e 's/[ ]*-l/,/g'
}

python_prepare_all() {
	local libdir="${EPREFIX}"/usr/$(get_libdir)

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
		"${FILESDIR}"/${P}-test_basic.patch
	)

	distutils-r1_python_prepare_all
}

python_compile() {
	distutils-r1_python_compile ${SCIPY_FCONFIG}
}

python_test() {
	distutils_install_for_testing ${SCIPY_FCONFIG}

	cd "${TMPDIR}" || die
	"${PYTHON}" -c "
import scipy, sys
r = scipy.test('full', verbose=10)
sys.exit(0 if r.wasSuccessful() else 1)" || die "Tests fail with ${EPYTHON}"
}

python_install() {
	distutils-r1_python_install ${SCIPY_FCONFIG}

	if use doc; then
		dohtml -r "${WORKDIR}"/html/.
		dodoc "${DISTDIR}"/${P}*pdf
	fi
}

pkg_postinst() {
	elog "You might want to set the variable SCIPY_PIL_IMAGE_VIEWER"
	elog "to your prefered image viewer if you don't like the default one. Ex:"
	elog "\t echo \"export SCIPY_PIL_IMAGE_VIEWER=display\" >> ~/.bashrc"
}
