# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-swiftclient/python-swiftclient-1.6.0.ebuild,v 1.1 2013/09/17 19:08:59 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

#testrepository doesn't exist
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
		test? ( ~dev-python/pep8-1.4.5[${PYTHON_USEDEP}]
				~dev-python/pyflakes-0.7.2[${PYTHON_USEDEP}]
				~dev-python/flake8-2.0[${PYTHON_USEDEP}]
				dev-python/coverage[${PYTHON_USEDEP}]
				>=dev-python/mock-0.8.0[${PYTHON_USEDEP}]
				dev-python/python-keystoneclient[${PYTHON_USEDEP}]
				>=dev-python/sphinx-1.1.2[${PYTHON_USEDEP}]
				>=dev-python/testrepository-0.0.13[${PYTHON_USEDEP}]
				>=dev-python/testtools-0.9.22[${PYTHON_USEDEP}] )"

RDEPEND=">=dev-python/simplejson-2.0.9[${PYTHON_USEDEP}]
		>=dev-python/pbr-0.5[${PYTHON_USEDEP}]
		<dev-python/pbr-0.6[${PYTHON_USEDEP}]
		>=dev-python/d2to1-0.2.10[${PYTHON_USEDEP}]
		<dev-python/d2to1-0.3[${PYTHON_USEDEP}]"

python_prepare() {
	sed -i '/discover/d' "${S}/test-requirements.txt" || die "sed failed"
	distutils-r1_python_prepare
}

python_test() {
	sh run_tests.sh | die
}
