# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/mt_dolphin_ia/mt_dolphin_ia-0.1.98.ebuild,v 1.7 2010/11/08 19:55:44 hwoarang Exp $

EAPI=2
inherit games

DESCRIPTION="client for the french tarot game maitretarot"
HOMEPAGE="http://www.nongnu.org/maitretarot/"
SRC_URI="http://savannah.nongnu.org/download/maitretarot/${PN}.pkg/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="dev-libs/glib:2
	dev-libs/libxml2
	dev-games/libmaitretarot
	dev-games/libmt_client"

src_install() {
	emake DESTDIR="${D}" install ||
	dodoc AUTHORS ChangeLog NEWS README
	prepgamesdirs
}
