# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pycparser/pycparser-2.07.ebuild,v 1.1 2012/07/27 12:26:24 djc Exp $

EAPI="4"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5 3.0 3.1"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

DESCRIPTION="C parser and AST generator written in Python"
HOMEPAGE="http://code.google.com/p/pycparser/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/ply"
RDEPEND="${DEPEND}"
