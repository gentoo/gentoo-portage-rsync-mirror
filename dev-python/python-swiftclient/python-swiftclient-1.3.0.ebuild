# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-swiftclient/python-swiftclient-1.3.0.ebuild,v 1.1 2013/03/11 02:27:19 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

#restricted due to packages missing and bad depends in the test ==webob-1.0.8   
RESTRICT="test"
inherit distutils-r1

DESCRIPTION="Python bindings to the OpenStack Object Storage API"
HOMEPAGE="http://docs.openstack.org/developer/python-swiftclient"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		test? ( dev-python/eventlet[${PYTHON_USEDEP}]
				dev-python/nose[${PYTHON_USEDEP}]
				dev-python/nose-exclude[${PYTHON_USEDEP}]
				dev-python/nosehtmloutput[${PYTHON_USEDEP}]
				dev-python/nosexcover
				dev-python/openstack-nose-plugin[${PYTHON_USEDEP}]
				=dev-python/pep8-1.3.3
				dev-python/python-keystoneclient[${PYTHON_USEDEP}]
				>=dev-python/sphinx-1.1.2[${PYTHON_USEDEP}]
				>=dev-python/testtools-0.9.22[${PYTHON_USEDEP}] )"
RDEPEND="dev-python/simplejson[${PYTHON_USEDEP}]"

python_test() {
	sh run_tests.sh | die
}
