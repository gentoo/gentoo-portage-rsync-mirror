# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/testrepository/testrepository-0.0.17-r2.ebuild,v 1.1 2014/01/02 15:17:55 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_2,3_3} pypy2_0 )

inherit distutils-r1

DESCRIPTION="A repository of test results."
HOMEPAGE="https://launchpad.net/testscenarios"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		test? ( ${RDEPEND}
			dev-python/testresources[$(python_gen_usedep python{2_7,3_2})]
			dev-python/testscenarios[$(python_gen_usedep python{2_7,3_2})]
			dev-python/pytz[${PYTHON_USEDEP}]
		)"
#>=dev-python/subunit-0.0.10[${PYTHON_USEDEP}]
#>=dev-python/testtools-0.9.30[${PYTHON_USEDEP}]
#dev-python/fixtures[${PYTHON_USEDEP}]
#bzr is listed but presumably req'd for a live repo test run
RDEPEND=">=dev-python/subunit-0.0.10[${PYTHON_USEDEP}]
		>=dev-python/testtools-0.9.30[${PYTHON_USEDEP}]
		dev-python/fixtures[${PYTHON_USEDEP}]"

REQUIRED_USE="test? ( $(python_gen_useflags python{2_7,3_2}) )"

python_test() {
	# The running has a gentoo python style bug, yet unknown, that corrupts the passing of
	# impls other than py2.7. A wip
	if [ "${EPYTHON}" == python2.7 ]; then
		"${PYTHON}" ./testr init || die
		"${PYTHON}" ./testr run || die "tests failed under ${EPYTHON}"
	fi
}
