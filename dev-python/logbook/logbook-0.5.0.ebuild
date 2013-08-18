# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/logbook/logbook-0.5.0.ebuild,v 1.1 2013/08/18 08:46:31 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_3} pypy2_0 )

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
	doc? ( >=dev-python/sphinx-1.1.3-r3[${PYTHON_USEDEP}] )"

PATCHES=( "${FILESDIR}"/${PN}-0.4.2-objectsinv.patch \
		"${FILESDIR}"/${PN}-0.5-pypy-test-fix.patch )

python_compile_all() {
	use doc && emake -C docs html
}

python_test() {
	nosetests -w tests || die "Tests failed under ${EPYTHON}"
}

python_install_all() {
	use doc && HTML_DOCS=( docs/_build/html/. )
	distutils-r1_python_install_all
}
