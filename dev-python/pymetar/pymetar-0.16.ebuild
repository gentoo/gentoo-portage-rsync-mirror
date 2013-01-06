# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pymetar/pymetar-0.16.ebuild,v 1.3 2010/04/11 13:08:31 nixnut Exp $

EAPI="2"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Downloads the weather report for a given station ID, decodes it and the provides easy access to all the data found in the report."
HOMEPAGE="http://www.schwarzvogel.de/software-pymetar.shtml"
SRC_URI="http://www.schwarzvogel.de/pkgs/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ppc ~sparc x86"
IUSE=""

DEPEND=""
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

DOCS="librarydoc.txt THANKS"
PYTHON_MODNAME="pymetar.py"

src_prepare() {
	distutils_src_prepare
	sed -e "s/'COPYING', //" -i setup.py || die "sed failed"
}

src_install() {
	doman pymetar.1
	rm -f pymetar.1
	distutils_src_install
}
