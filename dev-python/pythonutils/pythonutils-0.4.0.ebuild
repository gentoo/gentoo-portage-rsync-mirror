# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pythonutils/pythonutils-0.4.0.ebuild,v 1.1 2010/07/08 17:36:14 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Voidspace Python modules"
HOMEPAGE="http://www.voidspace.org.uk/python/pythonutils.html"
SRC_URI="http://www.voidspace.org.uk/downloads/${P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

src_install() {
	distutils_src_install

	dodoc docs/*.txt
	dohtml -r docs/*
}
