# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pywavelets/pywavelets-0.2.2-r1.ebuild,v 1.1 2013/08/12 18:31:13 bicatali Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

MY_PN="${PN/pyw/PyW}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python module for discrete, stationary, and packet wavelet transforms"
HOMEPAGE="http://www.pybytes.com/pywavelets"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc examples test"

DEPEND="
	app-arch/unzip
	dev-python/cython[${PYTHON_USEDEP}]
	test? ( dev-python/numpy[${PYTHON_USEDEP}] )
	doc? ( dev-python/sphinx )"
RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_P}"

DOCS=(CHANGES.txt THANKS.txt)

python_test() {
	PYTHONPATH="${BUILD_DIR}/lib" \
		${EPYTHON} tests/test_perfect_reconstruction.py || die
}

python_compile_all() {
	use doc && emake -C doc html
}

python_install_all() {
	distutils-r1_python_install_all
	use doc && dohtml -r doc/build/html/*
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins demo/*
	fi
}
