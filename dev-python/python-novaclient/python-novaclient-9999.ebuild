# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-novaclient/python-novaclient-9999.ebuild,v 1.7 2014/07/06 12:48:54 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python2_6 python2_7 )

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
				dev-python/simplejson )"
RDEPEND="dev-python/httplib2
		dev-python/prettytable
		dev-python/simplejson[${PYTHON_USEDEP}]"

python_test() {
	"${PYTHON}" setup.py nosetests || die
}
