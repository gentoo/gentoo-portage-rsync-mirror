# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-glanceclient/python-glanceclient-0.7.0.ebuild,v 1.4 2013/01/17 19:51:12 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="A client for the OpenStack Glance API"
HOMEPAGE="https://github.com/openstack/python-glanceclient"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
#IUSE="test"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
#		test? ( dev-python/mox 
#				dev-python/nose
#				dev-python/nosehtmloutput
#				dev-python/openstack-nose-plugin
#				dev-python/nose-exclude
#				=dev-python/pep8-1.3.3
#				>=dev-python/sphinx-1.1.2 )"
RDEPEND="virtual/python-argparse[${PYTHON_USEDEP}]
		dev-python/python-keystoneclient[${PYTHON_USEDEP}]
		<=dev-python/prettytable-0.7
		dev-python/pyopenssl
		dev-python/warlock[${PYTHON_USEDEP}]"

#python_test() {
#	"${PYTHON}" setup.py nosetests || die
#}
