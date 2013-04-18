# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/tinycss/tinycss-0.2-r2.ebuild,v 1.1 2013/04/18 16:40:27 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_2} )

inherit distutils-r1

DESCRIPTION="A complete yet simple CSS parser for Python"
HOMEPAGE="http://github.com/SimonSapin/tinycss/ http://packages.python.org/tinycss/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/lxml[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

DOCS=( CHANGES README.rst )

python_test() {
	export TINYCSS_SKIP_SPEEDUPS_TESTS=1
	local test
	for test in ${PN}/tests/test_*.py; do
		py.test $test
	done
}
