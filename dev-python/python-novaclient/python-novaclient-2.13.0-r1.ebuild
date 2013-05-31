# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-novaclient/python-novaclient-2.13.0-r1.ebuild,v 1.1 2013/05/31 14:46:49 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_6 python2_7 )

inherit distutils-r1

DESCRIPTION="A client for the OpenStack Nova API"
HOMEPAGE="https://github.com/openstack/python-novaclient"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

#need to package a bunch of stuff, they changed their test suite, again...
RESTRICT="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		test? ( >=dev-python/iso8601-0.1.4[${PYTHON_USEDEP}]
				dev-python/mock[${PYTHON_USEDEP}]
				dev-python/nose[${PYTHON_USEDEP}]
				>=dev-python/prettytable-0.6[${PYTHON_USEDEP}]
				<dev-python/prettytable-0.8[${PYTHON_USEDEP}]
				dev-python/pytest[${PYTHON_USEDEP}]
				dev-python/pytest-runner[${PYTHON_USEDEP}]
				dev-python/requests[${PYTHON_USEDEP}]
				dev-python/simplejson[${PYTHON_USEDEP}]
				virtual/python-unittest2[${PYTHON_USEDEP}] )"
RDEPEND="virtual/python-argparse[${PYTHON_USEDEP}]
		dev-python/httplib2[${PYTHON_USEDEP}]
		>=dev-python/iso8601-0.1.4[${PYTHON_USEDEP}]
		>=dev-python/prettytable-0.6[${PYTHON_USEDEP}]
		<dev-python/prettytable-0.7[${PYTHON_USEDEP}]
		>=dev-python/requests-0.8[${PYTHON_USEDEP}]
		dev-python/simplejson[${PYTHON_USEDEP}]"

python_test() {
	"${PYTHON}" setup.py nosetests || die
}
