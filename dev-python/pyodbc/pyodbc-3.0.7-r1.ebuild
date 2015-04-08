# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyodbc/pyodbc-3.0.7-r1.ebuild,v 1.1 2014/11/30 16:33:00 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 flag-o-matic

DESCRIPTION="python ODBC module to connect to almost any database"
HOMEPAGE="http://code.google.com/p/pyodbc"
SRC_URI="http://pyodbc.googlecode.com/files/${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mssql"

RDEPEND=">=dev-db/unixODBC-2.3.0
	mssql? ( >=dev-db/freetds-0.64[odbc] )"
DEPEND="${RDEPEND}
	app-arch/unzip
	dev-python/setuptools[${PYTHON_USEDEP}]"

python_configure_all() {
	append-cflags -fno-strict-aliasing
}
