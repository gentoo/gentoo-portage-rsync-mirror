# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyodbc/pyodbc-2.1.8.ebuild,v 1.4 2012/02/20 14:44:32 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython 2.7-pypy-*"

inherit distutils

DESCRIPTION="python ODBC module to connect to almost any database"
HOMEPAGE="http://code.google.com/p/pyodbc http://pypi.python.org/pypi/pyodbc"
SRC_URI="http://pyodbc.googlecode.com/files/${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mssql"

RDEPEND=">=dev-db/unixODBC-2.3.0
	mssql? ( >=dev-db/freetds-0.64[odbc] )"
DEPEND="${RDEPEND}
	app-arch/unzip
	dev-python/setuptools"

PYTHON_CXXFLAGS=("2.* + -fno-strict-aliasing")

src_prepare() {
	distutils_src_prepare

	# http://code.google.com/p/pyodbc/issues/detail?id=167
	sed -e "s/setuptools.core/setuptools/" -i setup.py
}
