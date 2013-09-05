# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/numdisplay/numdisplay-1.6.0-r1.ebuild,v 1.2 2013/09/05 18:46:47 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Python package for interactively displaying FITS arrays"
HOMEPAGE="http://stsdas.stsci.edu/numdisplay/"
SRC_URI="http://stsdas.stsci.edu/download/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND="dev-python/numpy[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

python_install() {
	distutils-r1_python_install
	find "${D}" -name LICENSE.txt -delete || die
}
