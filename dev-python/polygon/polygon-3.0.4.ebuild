# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/polygon/polygon-3.0.4.ebuild,v 1.5 2012/11/11 13:08:01 blueness Exp $

EAPI=3
PYTHON_DEPEND="3"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.*"

inherit distutils

DESCRIPTION="Python package to handle polygonal shapes in 2D"
HOMEPAGE="http://www.j-raedler.de/projects/polygon"
SRC_URI="mirror://github/jraedler/Polygon3/Polygon-${PV}a-src.zip"

LICENSE="LGPL-2"
SLOT="3"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}/Polygon-${PV}"

src_test() {
	testing() {
		PYTHONPATH="$(dir -d build-${PYTHON_ABI}/lib*)" "$(PYTHON)" test/Test.py
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	dodoc HISTORY doc/Polygon.txt
}
