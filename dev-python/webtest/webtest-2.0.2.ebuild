# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/webtest/webtest-2.0.2.ebuild,v 1.1 2013/03/21 07:02:59 patrick Exp $

EAPI=5

# sigh.
RESTRICT="test"

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )
PYTHON_TESTS_RESTRICTED_ABIS="3.*"

inherit distutils-r1

MY_PN="WebTest"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Helper to test WSGI applications"
HOMEPAGE="http://pythonpaste.org/webtest/ http://pypi.python.org/pypi/WebTest"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

RDEPEND=">=dev-python/webob-0.9.2[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	app-arch/unzip
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	test? ( dev-python/nose[${PYTHON_USEDEP}]
		dev-python/pyquery[${PYTHON_USEDEP}]
		dev-python/waitress[${PYTHON_USEDEP}]
		dev-python/wsgiproxy2[${PYTHON_USEDEP}]
		dev-python/paste
		dev-python/pastedeploy )"

S="${WORKDIR}/${MY_P}"

python_compile_all() {
	if use doc; then
		sphinx-build docs html || die
	fi
}

python_test() {
	nosetests || die "Tests fail with ${EPYTHON}"
}

python_install() {
	distutils-r1_python_install

	# Why is it so?
	if [[ ${EPYTHON} == python3* ]]; then
		rm -f "${D}$(python_get_sitedir)"/webtest/lint3.py
	fi
}

python_install_all() {
	use doc && local HTML_DOCS=( html/. )
	distutils-r1_python_install_all
}
