# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/fonttools/fonttools-2.4.ebuild,v 1.4 2015/03/28 21:26:41 ago Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )
PYTHON_REQ_USE="xml(+)"

inherit distutils-r1

DESCRIPTION="Library for manipulating TrueType, OpenType, AFM and Type1 fonts"
HOMEPAGE="http://fonttools.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm ~arm64 ~ia64 ppc ~x86"
IUSE=""

DEPEND=">=dev-python/numpy-1.0.2[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

DOCS=( README.txt Doc/{changes.txt,install.txt} )

python_install_all() {
	dohtml Doc/documentation.html || die "dohtml failed"
	distutils-r1_python_install_all
}
