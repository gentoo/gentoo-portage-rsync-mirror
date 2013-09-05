# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/logbook/logbook-0.4.2.ebuild,v 1.2 2013/09/05 18:46:07 mgorny Exp $

EAPI=5
# py3.2 fails tests & is marked to be dropped next release which will be very soon
# along with py2.5. See issue/86
PYTHON_COMPAT=( python{2_6,2_7,3_3} )

inherit distutils-r1

DESCRIPTION="A logging replacement for Python"
HOMEPAGE="http://packages.python.org/Logbook/ http://pypi.python.org/pypi/Logbook"
SRC_URI="https://github.com/mitsuhiko/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"
DISTUTILS_IN_SOURCE_BUILD=1

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( virtual/python-json[${PYTHON_USEDEP}]
		dev-python/nose[${PYTHON_USEDEP}] )
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )"

PATCHES=( "${FILESDIR}"/${P}-objectsinv.patch )

python_compile_all() {
	use doc && emake -C docs html
}

python_compile() {
	# https://github.com/mitsuhiko/logbook/issues/86
	distutils-r1_python_compile
	pushd "${BUILD_DIR}"/lib/ > /dev/null
	if [[ "${EPYTHON}" != 'python2.5' ]]; then
		rm $(find . -name _stringfmt.py) || die
	fi
}

python_test() {
	# https://github.com/mitsuhiko/logbook/issues/86
	nosetests tests || die
}

python_install_all() {
	use doc && HTML_DOCS=( docs/_build/html/. )
	distutils-r1_python_install_all
}
