# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-keystoneclient/python-keystoneclient-9999.ebuild,v 1.2 2013/01/11 22:19:40 prometheanfire Exp $

EAPI=5
#restricted due to packages missing and bad depends in the test ==webob-1.0.8
RESTRICT="test"
PYTHON_COMPAT=( python2_5 python2_6 python2_7 )

inherit git-2 distutils-r1

DESCRIPTION="A client for the OpenStack Keystone API"
HOMEPAGE="https://github.com/openstack/python-keystoneclient"
EGIT_REPO_URI="https://github.com/openstack/python-keystoneclient.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE=""
#IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="dev-python/httplib2
		dev-python/prettytable
		dev-python/requests
		dev-python/simplejson[${PYTHON_USEDEP}]
		virtual/python-argparse[${PYTHON_USEDEP}]"
#		test? ( dev-python/Babel
#			dev-python/coverage
#			dev-python/iso8601
#			dev-python/keyring
#			dev-python/mock
#			dev-python/mox
#			dev-python/nose
#			dev-python/nose-exclude		#not packaged
#			dev-python/nosehtmloutput	#not packaged
#			>=dev-python/pep8-1.3.3
#			>=app-misc/sphinx-1.1.2
#			dev-python/unittest2
#			>=dev-python/webob-1.0.8 )"
#
#python_test() {
#	"${PYTHON} setup.py nosetests || die
#}
