# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/fonttools/fonttools-2.3-r1.ebuild,v 1.3 2015/04/08 08:05:09 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="xml(+)"

inherit distutils-r1

DESCRIPTION="Library for manipulating TrueType, OpenType, AFM and Type1 fonts"
HOMEPAGE="http://fonttools.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ia64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-python/numpy-1.0.2[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

DOCS=( README.txt Doc/{changes.txt,install.txt} )

python_install_all() {
	dohtml Doc/documentation.html || die "dohtml failed"
	distutils-r1_python_install_all
}
