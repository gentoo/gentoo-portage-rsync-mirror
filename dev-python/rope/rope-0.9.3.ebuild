# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/rope/rope-0.9.3.ebuild,v 1.9 2012/05/29 12:07:58 ago Exp $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"
PYTHON_TESTS_FAILURES_TOLERANT_ABIS="2.7-pypy-*"

inherit distutils eutils

DESCRIPTION="Python refactoring library"
HOMEPAGE="http://rope.sourceforge.net/ http://pypi.python.org/pypi/rope"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${P}-fix_tests_results.patch" \
		"${FILESDIR}"/${P}-python2.7.patch
}

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib:." "$(PYTHON)" ropetest/__init__.py
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	docinto docs
	dodoc docs/*.txt
}
