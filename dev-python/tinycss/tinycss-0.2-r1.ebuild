# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/tinycss/tinycss-0.2-r1.ebuild,v 1.1 2013/01/16 17:31:30 idella4 Exp $

EAPI=4

PYTHON_DEPEND="2:2.7 3:3.2"
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="2.5 2.6 3.1 *-jython"
DISTUTILS_SRC_TEST="py.test"
inherit distutils

DESCRIPTION="A complete yet simple CSS parser for Python"
HOMEPAGE="http://github.com/SimonSapin/tinycss/ http://packages.python.org/tinycss/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/lxml"
DEPEND="${RDEPEND}"

DOCS="CHANGES README.rst"

src_test() {
	export TINYCSS_SKIP_SPEEDUPS_TESTS=1
	testing() {
		for test in ${PN}/tests/test_*.py; do
			PYTHONPATH=. py.test $test
		done
	}
	python_execute_function testing
}
