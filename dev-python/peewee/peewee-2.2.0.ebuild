# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/peewee/peewee-2.2.0.ebuild,v 1.1 2014/05/26 08:28:16 patrick Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Small python ORM"
HOMEPAGE="https://github.com/coleifer/peewee/"
SRC_URI="https://github.com/coleifer/${PN}/archive/${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples test"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/apsw[${PYTHON_USEDEP}]
		dev-python/psycopg[${PYTHON_USEDEP}]
	)"

python_test() {
	"${PYTHON}" ./runtests.py || die "tests failed"
}

python_install_all() {
	use examples && local EXAMPLES=( example/. )
	distutils-r1_python_install_all
}
