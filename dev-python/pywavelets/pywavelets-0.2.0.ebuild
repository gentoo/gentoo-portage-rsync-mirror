# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pywavelets/pywavelets-0.2.0.ebuild,v 1.6 2012/08/02 17:57:17 bicatali Exp $

EAPI=4
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython 2.7-pypy-*"

inherit distutils

MY_PN="${PN/pyw/PyW}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python module for discrete, stationary, and packet wavelet transforms."
HOMEPAGE="http://www.pybytes.com/pywavelets/ http://pypi.python.org/pypi/PyWavelets"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc examples test"

DEPEND="dev-python/cython
	test? ( dev-python/numpy )"
RDEPEND="dev-python/numpy"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES.txt THANKS.txt"
PYTHON_MODNAME="pywt"

src_prepare() {
	distutils_src_prepare
	# https://bitbucket.org/nigma/pywt/changeset/784802d4118c
	sed -e "167s/__new__/__cinit__/" -i src/_pywt.pyx
}

src_test() {
	testing() {
		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib.*)" \
			"$(PYTHON)" tests/test_perfect_reconstruction.py
	}
	python_execute_function testing
}

src_install () {
	distutils_src_install
	use doc && dohtml -r doc/build/html/*
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins demo/* || die "doins failed"
	fi
}
