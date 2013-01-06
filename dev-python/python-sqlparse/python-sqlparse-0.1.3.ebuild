# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-sqlparse/python-sqlparse-0.1.3.ebuild,v 1.1 2012/02/15 16:18:25 jlec Exp $

EAPI=4

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
PYTHON_MODNAME="${PN#python-}"

inherit distutils

DESCRIPTION="A non-validating SQL parser module for Python"
HOMEPAGE="http://code.google.com/p/python-sqlparse/"
SRC_URI="http://python-sqlparse.googlecode.com/files/${P#python-}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="BSD-2"
IUSE=""

S="${WORKDIR}"/${P#python-}
