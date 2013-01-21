# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/openstack-nose-plugin/openstack-nose-plugin-0.11.ebuild,v 1.1 2013/01/21 09:01:41 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="openstack run_tests.py style output for nosetests"
HOMEPAGE="https://github.com/openstack-dev/openstack-nose"
MY_PN="openstack.nose_plugin"
SRC_URI="mirror://pypi/${PN:0:1}/${MY_PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="virtual/python-argparse[${PYTHON_USEDEP}]
		dev-python/colorama[${PYTHON_USEDEP}]
		<=dev-python/prettytable-0.7
		>=dev-python/requests-1.0[${PYTHON_USEDEP}]
		dev-python/simplejson
		dev-python/termcolor[${PYTHON_USEDEP}]"
