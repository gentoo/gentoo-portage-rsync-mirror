# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-novaclient/python-novaclient-9999.ebuild,v 1.2 2013/01/01 06:45:42 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_5 python2_6 python2_7 )

inherit distutils-r1 git-2

EGIT_REPO_URI="git://github.com/openstack/${PN}.git
	https://github.com/openstack/${PN}.git"

DESCRIPTION="This is a client for the OpenStack Nova API."
HOMEPAGE="https://github.com/openstack/python-novaclient"
#SRC_URI="git://github.com/openstack/python-novaclient.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		test? ( dev-python/iso8601
				dev-python/mock
				dev-python/nose
				dev-python/prettytable
				dev-python/pytest
				dev-python/pytest-runner
				dev-python/requests
				dev-python/simplejson
				dev-python/unittest2 )"
RDEPEND="virtual/python-argparse
		dev-python/httplib2
		dev-python/prettytable
		dev-python/simplejson"

python_test() {
	"${PYTHON}" setup.py nosetests || die
}
