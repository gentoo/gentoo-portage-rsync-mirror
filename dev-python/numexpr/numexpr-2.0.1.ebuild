# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/numexpr/numexpr-2.0.1.ebuild,v 1.2 2012/02/22 09:52:10 patrick Exp $

EAPI=3

SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* 2.7-pypy-* *-jython"

inherit distutils

DESCRIPTION="Fast numerical array expression evaluator for Python and NumPy."
HOMEPAGE="http://code.google.com/p/numexpr/ http://pypi.python.org/pypi/numexpr"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="mkl"

RDEPEND="dev-python/numpy
	mkl? ( sci-libs/mkl )"
DEPEND="${RDEPEND}
	dev-python/setuptools"

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

src_test() {
	testing() {
		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib.*)" \
			"$(PYTHON)" ${PN}/tests/test_${PN}.py
	}
	python_execute_function testing
}
