# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/peewee/peewee-2.4.5.ebuild,v 1.2 2015/01/16 03:38:36 patrick Exp $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} )
PYTHON_REQ_USE="sqlite(+)"

inherit distutils-r1

DESCRIPTION="Small python ORM"
HOMEPAGE="https://github.com/coleifer/peewee/"
SRC_URI="https://github.com/coleifer/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc examples test"

RDEPEND=""
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/apsw[${PYTHON_USEDEP}]
		dev-python/psycopg[${PYTHON_USEDEP}]
		dev-python/django[${PYTHON_USEDEP}]
	)"
# Req'd to ensure a unique tmp.db for each python impl running the testsuite.
DISTUTILS_IN_SOURCE_BUILD=1

python_compile_all() {
	use doc && emake -C docs html
}

python_test() {
	"${PYTHON}" ./runtests.py || die "tests failed under ${EPYTHON}"
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/_build/html/. )
	use examples && local EXAMPLES=( examples/. )
	distutils-r1_python_install_all
}
