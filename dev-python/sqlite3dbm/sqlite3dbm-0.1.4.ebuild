# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sqlite3dbm/sqlite3dbm-0.1.4.ebuild,v 1.4 2012/09/29 06:54:25 heroxbd Exp $

EAPI=4

SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="3.* 2.5-jython"
PYTHON_USE_WITH="sqlite"

inherit distutils vcs-snapshot

DESCRIPTION="An sqlite-backed dictionary"
HOMEPAGE="https://github.com/Yelp/sqlite3dbm http://pypi.python.org/pypi/sqlite3dbm/"
SRC_URI="https://github.com/Yelp/${PN}/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc test"

RDEPEND=""
DEPEND="dev-python/setuptools
	doc? ( dev-python/sphinx )
	test? ( dev-python/testify )"

DOCS="AUTHORS.txt CHANGES.txt README.md"

src_compile() {
	distutils_src_compile
	if use doc ; then
		emake -C docs html
	fi
}

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib/" testify tests
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	if use doc; then
		dohtml -r docs/_build/html/
	fi
}
