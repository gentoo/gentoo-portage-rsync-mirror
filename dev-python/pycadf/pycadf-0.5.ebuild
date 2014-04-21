# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pycadf/pycadf-0.5.ebuild,v 1.1 2014/04/21 00:13:03 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="python implementation of DMTF Cloud Audit (CADF) data model"
HOMEPAGE="https://pypi.python.org/pypi/pycadf"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		>=dev-python/pbr-0.6[${PYTHON_USEDEP}]
		<dev-python/pbr-1.0[${PYTHON_USEDEP}]
	test? ( >=dev-python/sphinx-1.1.2[${PYTHON_USEDEP}]
			<dev-python/sphinx-1.2[${PYTHON_USEDEP}]
			dev-python/oslo-sphinx[${PYTHON_USEDEP}]
			~dev-python/docutils-0.9.1[${PYTHON_USEDEP}]
			>=dev-python/hacking-0.8.0[${PYTHON_USEDEP}]
			<dev-python/hacking-0.9[${PYTHON_USEDEP}]
			>=dev-python/fixtures-0.3.14[${PYTHON_USEDEP}]
			dev-python/nose[${PYTHON_USEDEP}]
			>=dev-python/mock-1.0[${PYTHON_USEDEP}]
			>=dev-python/mox-0.5.3[${PYTHON_USEDEP}]
			>=dev-python/subunit-0.0.18[${PYTHON_USEDEP}]
			>=dev-python/coverage-3.6[${PYTHON_USEDEP}]
			>=dev-python/testrepository-0.0.18[${PYTHON_USEDEP}]
			>=dev-python/testscenarios-0.4[${PYTHON_USEDEP}]
			>=dev-python/testtools-0.9.34[${PYTHON_USEDEP}] )"
RDEPEND="virtual/python-argparse[${PYTHON_USEDEP}]
		>=dev-python/Babel-1.3[${PYTHON_USEDEP}]
		>=dev-python/iso8601-0.1.9[${PYTHON_USEDEP}]
		>=dev-python/netaddr-0.7.6[${PYTHON_USEDEP}]
		>=dev-python/oslo-config-1.2.0[${PYTHON_USEDEP}]
		>=dev-python/oslo-messaging-1.3.0[${PYTHON_USEDEP}]
		>=dev-python/pytz-2010h[${PYTHON_USEDEP}]
		>=dev-python/six-1.5.2[${PYTHON_USEDEP}]
		>=dev-python/webob-1.2.3[${PYTHON_USEDEP}]"

# This time half the doc files are missing; Do you want them?

python_test() {
	nosetests tests/ || die "test failed under ${EPYTHON}"
}
