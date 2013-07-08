# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/storm/storm-0.20.ebuild,v 1.1 2013/07/08 05:35:00 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
PYTHON_TESTS_FAILURES_TOLERANT_ABIS="*-jython"

inherit distutils

DESCRIPTION="An object-relational mapper for Python developed at Canonical."
HOMEPAGE="https://storm.canonical.com/ http://pypi.python.org/pypi/storm"
SRC_URI="http://launchpad.net/storm/trunk/${PV}/+download/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mysql postgres sqlite test"

RDEPEND="mysql? ( dev-python/mysql-python )
	postgres? ( =dev-python/psycopg-2* )
	sqlite? ( || ( dev-lang/python:2.7[sqlite] dev-lang/python:2.6[sqlite] dev-lang/python:2.5[sqlite] dev-python/pysqlite:2 ) )"
DEPEND="dev-python/setuptools
	test? ( || ( dev-lang/python:2.7[sqlite] dev-lang/python:2.6[sqlite] dev-lang/python:2.5[sqlite] dev-python/pysqlite:2 ) 
		dev-python/fixtures )"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"
DOCS="tests/tutorial.txt"

src_prepare() {
	distutils_src_prepare

	preparation() {
		if [[ "$(python_get_implementation)" == "Jython" ]]; then
			sed -e "s/BUILD_CEXTENSIONS = True/BUILD_CEXTENSIONS = False/" -i setup.py
		fi
	}
	python_execute_function -s preparation
}

src_test() {
	if use mysql; then
		elog "To run the MySQL-tests, you need:"
		elog "  - a running mysql-server"
		elog "  - an already existing database 'db'"
		elog "  - a user 'user' with full permissions on that database"
		elog "  - and an environment variable STORM_MYSQL_URI=\"mysql://user:password@host:1234/db\""
	fi
	if use postgres; then
		elog "To run the PostgreSQL-tests, you need:"
		elog "  - a running postgresql-server"
		elog "  - an already existing database 'db'"
		elog "  - a user 'user' with full permissions on that database"
		elog "  - and an environment variable STORM_POSTGRES_URI=\"postgres://user:password@host:1234/db\""
	fi

	testing() {
		PYTHONPATH="$(ls -d build/lib*)" "$(PYTHON)" test --verbose
	}
	python_execute_function -s testing
}

src_install() {
	distutils_src_install
	python_clean_installation_image
}
