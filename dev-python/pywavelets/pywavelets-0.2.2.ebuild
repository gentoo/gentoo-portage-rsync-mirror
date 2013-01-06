# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pywavelets/pywavelets-0.2.2.ebuild,v 1.4 2012/11/27 11:30:52 idella4 Exp $

EAPI=4
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5 3.* *-jython 2.7-pypy-*"

inherit distutils

MY_PN="${PN/pyw/PyW}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python module for discrete, stationary, and packet wavelet transforms."
HOMEPAGE="http://www.pybytes.com/pywavelets/ http://pypi.python.org/pypi/PyWavelets"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc examples test"

DEPEND="app-arch/unzip
	dev-python/cython
	test? ( dev-python/numpy )
	doc? ( dev-python/sphinx )"
RDEPEND="dev-python/numpy"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES.txt THANKS.txt"
PYTHON_MODNAME="pywt"

src_test() {
	testing() {
		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib.*)" \
			"$(PYTHON)" tests/test_perfect_reconstruction.py
	}
	python_execute_function testing
}

src_compile() {
	distutils_src_compile
	use doc && emake -C doc html || die "emake html failed"
}

src_install () {
	distutils_src_install
	use doc && dohtml -r doc/build/html/*
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins demo/* || die "doins failed"
	fi
}
