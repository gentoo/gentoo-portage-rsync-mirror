# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/fixtures/fixtures-0.3.14.ebuild,v 1.1 2013/09/26 00:43:09 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit distutils-r1

DESCRIPTION="Fixtures, reusable state for writing clean tests and more."
HOMEPAGE="https://launchpad.net/python-fixtures https://pypi.python.org/pypi/fixtures"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="|| ( Apache-2.0 BSD )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

# nose not listed but provides coverage output of tests
# run of test files by python lacks any output except on fail
DEPEND="test? ( dev-python/nose[${PYTHON_USEDEP}] )"
RDEPEND=">=dev-python/testtools-0.9.22"
DISTUTILS_IN_SOURCE_BUILD=1

python_test() {
	pushd "${BUILD_DIR}"/ > /dev/null
	ln -sf ../README .
	nosetests lib/${PN}/tests/{test_callmany.py,test_fixture.py,test_testcase.py} \
		 || die "Tests failed under ${EPYTHON}"
}
