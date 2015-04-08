# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sqlite3dbm/sqlite3dbm-0.1.4-r1.ebuild,v 1.1 2013/07/01 09:40:08 dev-zero Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )
PYTHON_REQ_USE="sqlite"

inherit distutils-r1

# TODO: strip the -git at some version bump, introduced to avoid clash with
# earlier tarball
DESCRIPTION="An sqlite-backed dictionary"
HOMEPAGE="https://github.com/Yelp/sqlite3dbm http://pypi.python.org/pypi/sqlite3dbm/"
SRC_URI="https://github.com/Yelp/${PN}/archive/v${PV}.tar.gz -> ${P}-git.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc test"

RDEPEND=""
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx )
	test? ( dev-python/testify[${PYTHON_USEDEP}] )"

DOCS=(AUTHORS.txt CHANGES.txt README.md)

python_compile_all() {
	use doc && emake -C docs html
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/_build/html/. )
	distutils-r1_python_install_all
}

src_test() {
	testify tests || die
}
