# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/testfixtures/testfixtures-3.0.0.ebuild,v 1.1 2013/03/15 20:58:09 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python2_{6,7} python3_2 )

inherit distutils-r1

DESCRIPTION="A collection of helpers and mock objects for unit tests and doc tests"
HOMEPAGE="http://pypi.python.org/pypi/testfixtures/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE="doc test"

RDEPEND=""
DEPEND="${RDEPEND}
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	test? ( dev-python/manuel[${PYTHON_USEDEP}] )"

src_prepare() {
	sed -e s':../bin/sphinx-build:/usr/bin/sphinx-build:' \
		-i docs/Makefile || die

	# remove test that tests the stripped zope-component test_components.ComponentsTests
	rm -f testfixtures/tests/test_components.py || die
	distutils-r1_src_prepare
}

python_compile_all() {
	use doc && emake -C docs html
}

python_test() {
	py.test -v ${PN}/tests || die
}

python_install_all() {
	if use doc; then
		dohtml -r docs/_build/html/
	fi
}
