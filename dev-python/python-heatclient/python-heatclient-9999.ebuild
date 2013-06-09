# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-heatclient/python-heatclient-9999.ebuild,v 1.1 2013/06/09 02:02:39 prometheanfire Exp $

EAPI=5
#restricted due to not caring about 9999
RESTRICT="test"
PYTHON_COMPAT=( python2_7 )

inherit git-2 distutils-r1

DESCRIPTION="This is a client library for Heat built on the Heat orchestration
API."
HOMEPAGE="https://github.com/openstack/python-heatclient"
EGIT_REPO_URI="https://github.com/openstack/python-heatclient.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		test? ( dev-python/mox[${PYTHON_USEDEP}]
			dev-python/nose[${PYTHON_USEDEP}]
			dev-python/nose-exclude[${PYTHON_USEDEP}]
			dev-python/nosexcover
			dev-python/nosehtmloutput[${PYTHON_USEDEP}]
			dev-python/openstack-nose-plugin[${PYTHON_USEDEP}]
			=dev-python/pep8-1.4.5[${PYTHON_USEDEP}]
			=dev-python/pyflakes-0.7.2[${PYTHON_USEDEP}]
			>=dev-python/sphinx-1.1.2[${PYTHON_USEDEP}]
			>=dev-python/setuptools-git-0.4[${PYTHON_USEDEP}] )"
RDEPEND=">=dev-python/d2to1-0.2.10[${PYTHON_USEDEP}]
		<dev-python/d2to1-0.3[${PYTHON_USEDEP}]
		>=dev-python/pbr-0.5.10[${PYTHON_USEDEP}]
		<dev-python/pbr-0.6[${PYTHON_USEDEP}]
		dev-python/httplib2[${PYTHON_USEDEP}]
		>=dev-python/iso8601-0.1.4[${PYTHON_USEDEP}]
		>=dev-python/prettytable-0.6[${PYTHON_USEDEP}]
		<dev-python/prettytable-0.8[${PYTHON_USEDEP}]
		>=dev-python/python-keystoneclient-0.2[${PYTHON_USEDEP}]
		<dev-python/python-keystoneclient-0.3[${PYTHON_USEDEP}]
		virtual/python-argparse[${PYTHON_USEDEP}]"

python_test() {
	${PYTHON} setup.py nosetests || die
}
