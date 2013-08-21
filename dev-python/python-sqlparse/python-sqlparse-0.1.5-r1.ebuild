# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-sqlparse/python-sqlparse-0.1.5-r1.ebuild,v 1.1 2013/08/21 13:53:14 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="A non-validating SQL parser module for Python"
HOMEPAGE="http://code.google.com/p/python-sqlparse/ https://github.com/andialbrecht/sqlparse"
SRC_URI="http://python-sqlparse.googlecode.com/files/${P#python-}.tar.gz"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
LICENSE="BSD-2"
IUSE=""

S="${WORKDIR}"/${P#python-}

RESTRICT="test"

python_test() {
	${PYTHON} tests/run_tests.py || die
    nosetests --with-coverage --cover-inclusive --cover-package=sqlparse
}
