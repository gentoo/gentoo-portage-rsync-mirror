# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pysqlite/pysqlite-2.6.3.ebuild,v 1.8 2012/02/24 01:09:05 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython 2.7-pypy-*"

inherit distutils

DESCRIPTION="DB-API 2.0 interface for SQLite 3.x"
HOMEPAGE="http://code.google.com/p/pysqlite/ http://pypi.python.org/pypi/pysqlite"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="pysqlite"
SLOT="2"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE="examples"

DEPEND=">=dev-db/sqlite-3.3.8:3[extensions]"
RDEPEND=${DEPEND}

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

PYTHON_MODNAME="pysqlite2"

src_prepare() {
	distutils_src_prepare

	# Enable support for loadable sqlite extensions.
	sed -e "/define=SQLITE_OMIT_LOAD_EXTENSION/d" -i setup.cfg || die "sed setup.cfg failed"

	# Fix encoding.
	sed -e "s/\(coding: \)ISO-8859-1/\1utf-8/" -i lib/{__init__.py,dbapi2.py} || die "sed lib/{__init__.py,dbapi2.py} failed"

	# Workaround to make tests work without installing them.
	sed -e "s/pysqlite2.test/test/" -i lib/test/__init__.py || die "sed lib/test/__init__.py failed"
}

src_test() {
	cd lib

	testing() {
		PYTHONPATH="$(ls -d ../build-${PYTHON_ABI}/lib.*)" "$(PYTHON)" -c "from test import test; import sys; sys.exit(test())"
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	rm -rf "${ED}usr/pysqlite2-doc"

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins doc/includes/sqlite3/* || die "Installation of examples failed"
	fi

	delete_tests() {
		rm -fr "${ED}$(python_get_sitedir)/pysqlite2/test"
	}
	python_execute_function -q delete_tests
}
