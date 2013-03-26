# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-keystoneclient/python-keystoneclient-9999.ebuild,v 1.4 2013/03/26 06:09:02 prometheanfire Exp $

EAPI=5
#restricted due to packages missing and bad depends in the test ==webob-1.0.8
RESTRICT="test"
PYTHON_COMPAT=( python2_7 )

inherit git-2 distutils-r1

DESCRIPTION="A client for the OpenStack Keystone API"
HOMEPAGE="https://github.com/openstack/python-keystoneclient"
EGIT_REPO_URI="https://github.com/openstack/python-keystoneclient.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		test? ( dev-python/Babel[${PYTHON_USEDEP}]
			dev-python/coverage[${PYTHON_USEDEP}]
			dev-python/fixtures[${PYTHON_USEDEP}]
			dev-python/keyring[${PYTHON_USEDEP}]
			dev-python/mock[${PYTHON_USEDEP}]
			dev-python/mox[${PYTHON_USEDEP}]
			dev-python/nose[${PYTHON_USEDEP}]
			dev-python/nose-exclude[${PYTHON_USEDEP}]
			dev-python/nosehtmloutput[${PYTHON_USEDEP}]
			dev-python/openstack-nose-plugin[${PYTHON_USEDEP}]
			=dev-python/pep8-1.3.3
			>=dev-python/sphinx-1.1.2[${PYTHON_USEDEP}]
			>=dev-python/testtools-0.9.22[${PYTHON_USEDEP}]
			dev-python/unittest2[${PYTHON_USEDEP}]
			=dev-python/webob-1.0.8 )"
RDEPEND="dev-python/iso8601[${PYTHON_USEDEP}]
		dev-python/prettytable
		>=dev-python/requests-0.8.8
		<=dev-python/requests-1.0
		dev-python/simplejson[${PYTHON_USEDEP}]
		virtual/python-argparse[${PYTHON_USEDEP}]"

python_test() {
	${PYTHON} setup.py nosetests || die
}
