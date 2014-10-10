# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/krop/krop-0.4.6.ebuild,v 1.1 2014/10/10 15:45:09 dilfridge Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit eutils distutils-r1

DESCRIPTION="A tool to crop PDF files"
HOMEPAGE="http://arminstraub.com/software/krop"
SRC_URI="http://arminstraub.com/downloads/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/python-poppler-qt4[${PYTHON_USEDEP}]
	dev-python/pyPdf[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

src_install() {
	distutils-r1_src_install
	domenu "${WORKDIR}/${P}/${PN}.desktop"
}
