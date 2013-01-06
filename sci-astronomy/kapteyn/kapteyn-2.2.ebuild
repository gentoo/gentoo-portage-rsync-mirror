# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/kapteyn/kapteyn-2.2.ebuild,v 1.3 2012/08/05 17:57:22 bicatali Exp $

EAPI=4

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython 2.7-pypy-*"

inherit eutils distutils

DESCRIPTION="Collection of python tools for astronomy"
HOMEPAGE="http://www.astro.rug.nl/software/kapteyn"
SRC_URI="http://www.astro.rug.nl/software/kapteyn/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND=">=sci-astronomy/wcslib-4.13.4
	dev-python/numpy"
RDEPEND="${DEPEND}
	dev-python/pyfits
	dev-python/matplotlib"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")
DOCS="CHANGES.txt README.txt"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}"/${P}-debundle_wcs.patch
	rm -rf src/wcslib-4.*
}

src_install() {
	distutils_src_install
	dodoc doc/${PN}.pdf
}
