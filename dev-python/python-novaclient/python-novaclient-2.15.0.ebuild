# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-novaclient/python-novaclient-2.15.0.ebuild,v 1.3 2014/03/19 23:04:14 bicatali Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="A client for the OpenStack Nova API"
HOMEPAGE="https://github.com/openstack/python-novaclient"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		>=dev-python/pbr-0.5.21[${PYTHON_USEDEP}]
		<dev-python/pbr-1.0[${PYTHON_USEDEP}]
		test? ( >=dev-python/hacking-0.5.6[${PYTHON_USEDEP}]
				<dev-python/hacking-0.8[${PYTHON_USEDEP}]
				>=dev-python/coverage-3.6[${PYTHON_USEDEP}]
				>=dev-python/fixtures-0.3.12[${PYTHON_USEDEP}]
				>=dev-python/keyring-1.6.1[${PYTHON_USEDEP}]
				>=dev-python/mock-0.8.0[${PYTHON_USEDEP}]
				>=dev-python/sphinx-1.1.2[${PYTHON_USEDEP}]
				>=dev-python/testrepository-0.0.17[${PYTHON_USEDEP}]
				>=dev-python/testtools-0.9.32[${PYTHON_USEDEP}] )"
RDEPEND="virtual/python-argparse[${PYTHON_USEDEP}]
		>=dev-python/iso8601-0.1.4[${PYTHON_USEDEP}]
		>=dev-python/prettytable-0.6[${PYTHON_USEDEP}]
		<dev-python/prettytable-0.8[${PYTHON_USEDEP}]
		>=dev-python/requests-1.1[${PYTHON_USEDEP}]
		>=dev-python/simplejson-2.0.9[${PYTHON_USEDEP}]
		dev-python/six[${PYTHON_USEDEP}]
		>=dev-python/Babel-0.9.6-r1[${PYTHON_USEDEP}]"

python_test() {
	testr init
	testr run --parallel || die "testsuite failed under python2.7"
}
