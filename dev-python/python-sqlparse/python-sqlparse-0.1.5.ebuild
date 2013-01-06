# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-sqlparse/python-sqlparse-0.1.5.ebuild,v 1.5 2013/01/01 14:16:29 ago Exp $

EAPI=4

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
PYTHON_MODNAME="${PN#python-}"

inherit distutils

DESCRIPTION="A non-validating SQL parser module for Python"
HOMEPAGE="http://code.google.com/p/python-sqlparse/ https://github.com/andialbrecht/sqlparse"
SRC_URI="http://python-sqlparse.googlecode.com/files/${P#python-}.tar.gz"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="BSD-2"
IUSE=""

S="${WORKDIR}"/${P#python-}

RESTRICT="test"
