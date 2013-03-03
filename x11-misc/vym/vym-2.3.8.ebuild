# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/vym/vym-2.3.8.ebuild,v 1.2 2013/03/02 23:54:15 hwoarang Exp $

EAPI=4
inherit eutils qt4-r2

DESCRIPTION="View Your Mind, a mindmap tool"
HOMEPAGE="http://www.insilmaril.de/vym/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-qt/qtdbus:4
	dev-qt/qtgui:4[qt3support]
	dev-qt/qtsvg:4
"
RDEPEND="
	${DEPEND}
	app-arch/zip
"

DOCS="README.txt"

src_configure() {
	eqmake4 PREFIX=/usr DOCDIR=/usr/share/doc/${PF}
}

src_install() {
	qt4-r2_src_install
	doman doc/vym.1.gz
	make_desktop_entry vym vym /usr/share/vym/icons/vym.png Education
}
