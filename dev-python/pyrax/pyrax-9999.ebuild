# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyrax/pyrax-9999.ebuild,v 1.1 2013/03/04 20:37:29 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_6 python2_7 )

inherit distutils-r1 git-2

EGIT_REPO_URI="git://github.com/rackspace/${PN}.git
	https://github.com/rackspace/${PN}.git"

DESCRIPTION="Python SDK for OpenStack/Rackspace APIs"
HOMEPAGE="https://github.com/openstack/python-novaclient"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		test? (	dev-python/mock
				>=dev-python/python-novaclient-2.10.0[${PYTHON_USEDEP}]
				dev-python/python-swiftclient[${PYTHON_USEDEP}]
				virtual/python-unittest2[${PYTHON_USEDEP}] )"
RDEPEND="
		dev-python/httplib2[${PYTHON_USEDEP}]
		dev-python/keyring[${PYTHON_USEDEP}]
		dev-python/prettytable
		>=dev-python/python-novaclient-2.10.0[${PYTHON_USEDEP}]
		dev-python/python-swiftclient[${PYTHON_USEDEP}]
		dev-python/rackspace-novaclient[${PYTHON_USEDEP}]
		dev-python/simplejson[${PYTHON_USEDEP}]"

python_test() {
	"${PYTHON}" setup.py nosetests || die
}
