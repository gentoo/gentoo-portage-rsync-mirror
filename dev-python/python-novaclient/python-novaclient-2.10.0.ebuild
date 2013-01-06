# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-novaclient/python-novaclient-2.10.0.ebuild,v 1.2 2013/01/06 19:47:46 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python2_5 python2_6 python2_7 )

inherit distutils-r1

DESCRIPTION="This is a client for the OpenStack Nova API."
HOMEPAGE="https://github.com/openstack/python-novaclient"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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
				virtual/python-unittest2 )"
RDEPEND="virtual/python-argparse
		dev-python/httplib2
		dev-python/prettytable
		dev-python/simplejson"

python_test() {
	"${PYTHON}" setup.py nosetests || die
}
