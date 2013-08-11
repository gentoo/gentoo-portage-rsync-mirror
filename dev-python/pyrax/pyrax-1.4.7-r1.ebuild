# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyrax/pyrax-1.4.7-r1.ebuild,v 1.2 2013/08/11 05:12:24 patrick Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Python SDK for OpenStack/Rackspace APIs"
HOMEPAGE="https://github.com/openstack/python-novaclient"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test keyring"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		test? (	dev-python/mock[${PYTHON_USEDEP}]
				>=dev-python/python-novaclient-2.13.0[${PYTHON_USEDEP}]
				dev-python/python-swiftclient[${PYTHON_USEDEP}]
				virtual/python-unittest2[${PYTHON_USEDEP}] )"
RDEPEND="
		dev-python/httplib2[${PYTHON_USEDEP}]
		keyring? ( dev-python/keyring[${PYTHON_USEDEP}] )
		dev-python/prettytable[${PYTHON_USEDEP}]
		>=dev-python/python-novaclient-2.13.0[${PYTHON_USEDEP}]
		dev-python/python-swiftclient[${PYTHON_USEDEP}]
		dev-python/rackspace-novaclient[${PYTHON_USEDEP}]
		dev-python/simplejson[${PYTHON_USEDEP}]"

python_test() {
	"${PYTHON}" setup.py nosetests || die
}
