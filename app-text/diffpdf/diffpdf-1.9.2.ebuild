# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/diffpdf/diffpdf-1.9.2.ebuild,v 1.3 2013/03/17 16:00:23 dilfridge Exp $

EAPI=5

inherit qt4-r2 eutils

DESCRIPTION="Program that textually or visually compares two PDF files"
HOMEPAGE="http://www.qtrac.eu/diffpdf.html"
SRC_URI="http://www.qtrac.eu/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

DEPEND="
	>=app-text/poppler-0.12.3:=[qt4]
	>=dev-qt/qtcore-4.5:4
	>=dev-qt/qtgui-4.5:4
"
RDEPEND="${DEPEND}"

DOCS="README"

src_configure() {
	lrelease diffpdf.pro || die 'Generating translations failed'
	qt4-r2_src_configure
}

src_install() {
	qt4-r2_src_install

	dobin diffpdf
	doman diffpdf.1
}
