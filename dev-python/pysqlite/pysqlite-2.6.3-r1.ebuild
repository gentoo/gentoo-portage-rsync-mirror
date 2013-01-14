# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pysqlite/pysqlite-2.6.3-r1.ebuild,v 1.2 2013/01/14 21:11:20 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7} )

inherit distutils-r1 flag-o-matic

DESCRIPTION="DB-API 2.0 interface for SQLite 3.x"
HOMEPAGE="http://code.google.com/p/pysqlite/ http://pypi.python.org/pypi/pysqlite"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="pysqlite"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE="examples"

DEPEND=">=dev-db/sqlite-3.3.8:3[extensions]"
RDEPEND=${DEPEND}

python_prepare_all() {
	# Enable support for loadable sqlite extensions.
	sed -e "/define=SQLITE_OMIT_LOAD_EXTENSION/d" -i setup.cfg || die

	# Fix encoding.
	sed -e "/coding:/s:ISO-8859-1:utf-8:" \
		-i lib/{__init__.py,dbapi2.py} || die

	distutils-r1_python_prepare_all
}

python_configure_all() {
	append-flags -fno-strict-aliasing
}

python_test() {
	local script='
import sys, pysqlite2.test, unittest
r = unittest.TextTestRunner().run(pysqlite2.test.suite())
sys.exit(0 if r.wasSuccessful() else 1)'

	cd "${TMPDIR}" || die
	"${PYTHON}" -c "${script}" \
		|| die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_install_all

	rm -rf "${ED}usr/pysqlite2-doc"

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r doc/includes/sqlite3/. || die
	fi
}
