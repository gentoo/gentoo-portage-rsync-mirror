# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-swiftclient/python-swiftclient-1.8.0.ebuild,v 1.1 2013/11/15 06:51:33 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Python bindings to the OpenStack Object Storage API"
HOMEPAGE="https://launchpad.net/python-swiftclient"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( ~dev-python/pep8-1.4.5[${PYTHON_USEDEP}]
		~dev-python/pyflakes-0.7.2[${PYTHON_USEDEP}]
		~dev-python/flake8-2.0[${PYTHON_USEDEP}]
		dev-python/coverage[${PYTHON_USEDEP}]
		>=dev-python/mock-1.0[${PYTHON_USEDEP}]
		>=dev-python/python-keystoneclient-0.3.2[${PYTHON_USEDEP}]
		>=dev-python/sphinx-1.1.2[${PYTHON_USEDEP}]
		>=dev-python/testrepository-0.0.17[${PYTHON_USEDEP}]
		>=dev-python/testtools-0.9.32[${PYTHON_USEDEP}]
		>=dev-python/hacking-0.5.6[${PYTHON_USEDEP}]
		<dev-python/hacking-0.8[${PYTHON_USEDEP}]
	doc? ( >=dev-python/sphinx-1.1.2[${PYTHON_USEDEP}] )
		)"
RDEPEND=">=dev-python/simplejson-2.0.9[${PYTHON_USEDEP}]
	>=dev-python/pbr-0.5[${PYTHON_USEDEP}]
	<dev-python/pbr-0.6[${PYTHON_USEDEP}]
	>=dev-python/d2to1-0.2.10[${PYTHON_USEDEP}]
	<dev-python/d2to1-0.3[${PYTHON_USEDEP}]"

python_prepare() {
	sed -i '/discover/d' "${S}/test-requirements.txt" || die "sed failed"
	distutils-r1_python_prepare
}

python_compile_all() {
	use doc && emake -C doc html
}

python_test() {
	# https://bugs.launchpad.net/python-swiftclient/+bug/1251507
	nosetests tests -e test_instantiation || die "testsuite failed"
}

python_install_all() {
	use doc && local HTML_DOCS=( ../${P}-python2_7/doc/build/html/. )
	distutils-r1_python_install_all
}
