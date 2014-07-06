# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/webtest/webtest-2.0.14.ebuild,v 1.2 2014/07/06 13:04:55 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_2,3_3} )

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

RDEPEND="
	dev-python/six[${PYTHON_USEDEP}]
	>=dev-python/waitress-0.8.5[${PYTHON_USEDEP}]
	>=dev-python/webob-0.9.2[${PYTHON_USEDEP}]
	dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
	app-arch/unzip
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	test? ( dev-python/nose[${PYTHON_USEDEP}]
		dev-python/pyquery[${PYTHON_USEDEP}]
		dev-python/pastedeploy[${PYTHON_USEDEP}]
		dev-python/wsgiproxy2[${PYTHON_USEDEP}]
	)"

S="${WORKDIR}/${MY_P}"

# Makes testing easier; otherwise we get errors from pkg_resources.
DISTUTILS_IN_SOURCE_BUILD=1

python_compile_all() {
	if use doc; then
		sphinx-build docs html || die
	fi
}

src_test() {
	DISTUTILS_NO_PARALLEL_BUILD=1 distutils-r1_src_test
}

python_test() {
	# Tests raise ImportErrors with our default PYTHONPATH.
	local -x PYTHONPATH=
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
