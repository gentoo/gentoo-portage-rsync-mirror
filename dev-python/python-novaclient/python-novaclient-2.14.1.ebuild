# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-novaclient/python-novaclient-2.14.1.ebuild,v 1.2 2014/03/30 09:28:12 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

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
		test? ( >=dev-python/iso8601-0.1.4
				dev-python/mock
				dev-python/nose
				>=dev-python/prettytable-0.6
				<dev-python/prettytable-0.8
				dev-python/pytest
				dev-python/pytest-runner
				dev-python/requests
				dev-python/simplejson
				virtual/python-unittest2[${PYTHON_USEDEP}] )"
RDEPEND="virtual/python-argparse[${PYTHON_USEDEP}]
		>=dev-python/pbr-0.5.16[${PYTHON_USEDEP}]
		<dev-python/pbr-0.6[${PYTHON_USEDEP}]
		>=dev-python/iso8601-0.1.4[${PYTHON_USEDEP}]
		>=dev-python/prettytable-0.6[${PYTHON_USEDEP}]
		<dev-python/prettytable-0.8[${PYTHON_USEDEP}]
		>=dev-python/requests-1.1[${PYTHON_USEDEP}]
		>=dev-python/simplejson-2.0.9[${PYTHON_USEDEP}]
		dev-python/six[${PYTHON_USEDEP}]"

python_test() {
	"${PYTHON}" setup.py nosetests || die
}
