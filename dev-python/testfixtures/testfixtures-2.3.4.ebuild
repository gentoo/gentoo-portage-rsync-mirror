# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/testfixtures/testfixtures-2.3.4.ebuild,v 1.2 2012/05/22 16:04:18 tampakrap Exp $

EAPI=4
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="3.* *-pypy-* *-jython"
DISTUTILS_SRC_TEST="py.test"
inherit distutils eutils

DESCRIPTION="A collection of helpers and mock objects for unit tests and doc tests"
HOMEPAGE="http://pypi.python.org/pypi/testfixtures/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE="doc test"

RDEPEND=""
DEPEND="${RDEPEND}
	doc? ( dev-python/sphinx )"
#	test? ( dev-python/manuel )"

# Work in progress, requires dev-python/manuel
RESTRICT="test"

src_prepare() {
	sed -e s':../bin/sphinx-build:/usr/bin/sphinx-build:' \
		-i docs/Makefile || die
	epatch "${FILESDIR}"/${P}-adjust_tests.patch

	# remove test that tests the stripped zope-component test_components.ComponentsTests
	rm -f testfixtures/tests/test_components.py || die
	distutils_src_prepare
}
src_compile() {
	distutils_src_compile

	use doc && emake -C docs html
}

src_test() {
	distutils_src_test ${PN}/tests/
}

src_install() {
	distutils_src_install
	if use doc; then
		dohtml -r docs/_build/html/
	fi
}
