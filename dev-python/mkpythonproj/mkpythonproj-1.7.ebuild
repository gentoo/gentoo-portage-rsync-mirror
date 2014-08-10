# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mkpythonproj/mkpythonproj-1.7.ebuild,v 1.4 2014/08/10 21:13:56 slyfox Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils eutils

DESCRIPTION="Creates the framework for a new Python project or script"
HOMEPAGE="http://www.seanet.com/~hgg9140/comp/mkpythonproj/doc/index.html"
SRC_URI="http://www.seanet.com/~hgg9140/comp/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

PYTHON_MODNAME="mkproj"

src_prepare(){
	distutils_src_prepare
	epatch "${FILESDIR}/${PN}_licenses.patch"
}
