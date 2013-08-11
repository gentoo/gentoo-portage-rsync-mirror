# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-glanceclient/python-glanceclient-0.10.0.ebuild,v 1.1 2013/08/11 01:43:36 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

#tests restricted due to unpackaged deps
RESTRICT="test"
DESCRIPTION="A client for the OpenStack Glance API"
HOMEPAGE="https://github.com/openstack/python-glanceclient"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
#		test? ( dev-python/mox
#				dev-python/coverage
#				dev-python/discover						#not packaged
#				=dev-python/pep8-1.3.3
#				>=dev-python/setuptools-git-0.4
#				>=dev-python/sphinx-1.1.2
#				>=dev-python/testrepository-0.0.13		#not packaged
#				>=dev-python/testtools-0.9.22 )"
RDEPEND="virtual/python-argparse[${PYTHON_USEDEP}]
		>=dev-python/d2to1-0.2.10[${PYTHON_USEDEP}]
		<dev-python/d2to1-0.3[${PYTHON_USEDEP}]
		>=dev-python/pbr-0.5[${PYTHON_USEDEP}]
		<dev-python/pbr-0.6[${PYTHON_USEDEP}]
		>=dev-python/python-keystoneclient-0.2.1[${PYTHON_USEDEP}]
		<dev-python/python-keystoneclient-1[${PYTHON_USEDEP}]
		>=dev-python/prettytable-0.6[${PYTHON_USEDEP}]
		<dev-python/prettytable-0.8[${PYTHON_USEDEP}]
		dev-python/pyopenssl[${PYTHON_USEDEP}]
		>=dev-python/warlock-0.7.0[${PYTHON_USEDEP}]
		<dev-python/warlock-2[${PYTHON_USEDEP}]"

#python_test() {
#	"${PYTHON}" setup.py nosetests || die
#}
