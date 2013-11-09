# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyrax/pyrax-1.6.1.ebuild,v 1.1 2013/11/09 05:52:06 prometheanfire Exp $

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
				dev-python/nose[${PYTHON_USEDEP}]
				dev-python/httplib2[${PYTHON_USEDEP}]
				keyring? ( dev-python/keyring[${PYTHON_USEDEP}] )
				>=dev-python/python-novaclient-2.13.0[${PYTHON_USEDEP}]
				dev-python/rackspace-novaclient[${PYTHON_USEDEP}]
				>=dev-python/python-swiftclient-1.5.0[${PYTHON_USEDEP}] )"
RDEPEND="dev-python/httplib2[${PYTHON_USEDEP}]
		keyring? ( dev-python/keyring[${PYTHON_USEDEP}] )
		>=dev-python/python-novaclient-2.13.0[${PYTHON_USEDEP}]
		>=dev-python/python-swiftclient-1.5.0[${PYTHON_USEDEP}]
		dev-python/rackspace-novaclient[${PYTHON_USEDEP}]"

#python_test() {
#disabling due to failures https://github.com/rackspace/pyrax/issues/245
#	"${PYTHON}" -m nose -v tests/unit --with-cover --cover-package=pyrax || die
#	"${PYTHON}" -m nose -w tests/unit || die
#}
