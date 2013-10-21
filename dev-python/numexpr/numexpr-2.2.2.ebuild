# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/numexpr/numexpr-2.2.2.ebuild,v 1.1 2013/10/21 08:07:32 patrick Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit distutils-r1

DESCRIPTION="Fast numerical array expression evaluator for Python and NumPy."
HOMEPAGE="http://code.google.com/p/numexpr/ http://pypi.python.org/pypi/numexpr"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="mkl"

RDEPEND=">=dev-python/numpy-1.7.1[${PYTHON_USEDEP}]
	mkl? ( sci-libs/mkl )"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

DOCS=( ANNOUNCE.txt AUTHORS.txt README.txt RELEASE_NOTES.txt )

src_prepare() {
	# TODO: mkl can be used but it fails for me
	# only works with mkl in tree. newer mkl will use pkgconfig
	if use mkl; then
		local ext
		use amd64 && ext=_lp64
		cat <<- EOF > "${S}"/site.cfg
		[mkl]
		library_dirs = ${MKLROOT}/lib/em64t
		include_dirs = ${MKLROOT}/include
		mkl_libs = mkl_solver${ext}, mkl_intel${ext}, \
		mkl_intel_thread, mkl_core, iomp5
		EOF
	fi
}

python_test() {
	cd "${BUILD_DIR}"/lib* || die
	"${PYTHON}" -c "import numexpr; numexpr.test()" || die
}
