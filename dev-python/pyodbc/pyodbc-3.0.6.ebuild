# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyodbc/pyodbc-3.0.6.ebuild,v 1.2 2012/08/31 17:53:38 mr_bones_ Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="*-jython 2.7-pypy-* 2.5"

inherit distutils eutils

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
	dev-python/setuptools"

PYTHON_CXXFLAGS=("* + -fno-strict-aliasing")
