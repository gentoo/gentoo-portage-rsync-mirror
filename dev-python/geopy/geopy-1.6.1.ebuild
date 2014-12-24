# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/geopy/geopy-1.6.1.ebuild,v 1.1 2014/12/24 10:32:18 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="A Geocoding Toolbox for Python"
HOMEPAGE="http://www.geopy.org/ https://github.com/geopy/geopy"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

IUSE="test doc yahoo"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="yahoo? ( >=dev-python/requests-oauthlib-0.4.0[${PYTHON_USEDEP}]
		dev-python/placefinder[${PYTHON_USEDEP}] )"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}]
		dev-python/nose-cover3[${PYTHON_USEDEP}]
		dev-python/pylint[${PYTHON_USEDEP}] )
	 doc? ( $(python_gen_cond_dep 'dev-python/sphinx[${PYTHON_USEDEP}]' python2_7)
		>=dev-python/python-docs-2.7.6-r1:2.7 )"

python_prepare_all() {
	if use doc; then
		local PYTHON_DOC_ATOM=$(best_version --host-root dev-python/python-docs:2.7)
		local PYTHON_DOC_VERSION="${PYTHON_DOC_ATOM#dev-python/python-docs-}"
		local PYTHON_DOC="/usr/share/doc/python-docs-${PYTHON_DOC_VERSION}/html"
		local PYTHON_DOC_INVENTORY="${PYTHON_DOC}/objects.inv"
		sed -i "s|'http://docs.python.org/': None|'${PYTHON_DOC}': '${PYTHON_DOC_INVENTORY}'|" docs/conf.py || die
	fi

	distutils-r1_python_prepare_all

	# purge test folder to avoid file collisions
	sed -e "s:find_packages():find_packages(exclude=['test','test.*']):" -i setup.py || die
}

python_test() {
	# intermittent fails or errors caused by an apparent race condition. suite is fine
	# test test_geocode attempts to connect the network and is excluded here
	nosetests -e test_geocode || die "Tests failed under ${EPYTHON}"
}

python_compile_all() {
	use doc && emake -C docs html
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/_build/html/. )
	distutils-r1_python_install_all
}
