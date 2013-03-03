# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/clustalx/clustalx-2.1.ebuild,v 1.4 2013/03/02 23:15:41 hwoarang Exp $

EAPI=4

inherit eutils qt4-r2

DESCRIPTION="Graphical interface for the ClustalW multiple alignment program"
HOMEPAGE="http://www.ebi.ac.uk/tools/clustalw2/"
SRC_URI="http://www.clustal.org/download/current/${P}.tar.gz"

LICENSE="GPL-3 LGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-qt/qtcore:4
	dev-qt/qtgui:4"
RDEPEND="${DEPEND}
	>=sci-biology/clustalw-2.1"

src_prepare() {
	sed -e "s|colprot.xml|/usr/share/${PN}/colprot.xml|" \
			-e "s|coldna.xml|/usr/share/${PN}/coldna.xml|" \
			-e "s|colprint.xml|/usr/share/${PN}/colprint.xml|" \
			-i ClustalQtParams.h || \
			die "Failed to patch shared files location."
	sed -e "s|clustalx.hlp|/usr/share/${PN}/clustalx.hlp|" \
			-i HelpDisplayWidget.cpp || \
			die "Failed to patch help file location."
}

src_install() {
	dobin clustalx
	insinto /usr/share/${PN}
	doins colprot.xml coldna.xml colprint.xml clustalx.hlp
	make_desktop_entry ${PN} ClustalX
}
