# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/cutemaze/cutemaze-1.1.0.ebuild,v 1.3 2012/03/28 18:15:51 mr_bones_ Exp $

EAPI=2
inherit eutils qt4-r2 games

DESCRIPTION="A simple, top-down game in which mazes are randomly generated"
HOMEPAGE="http://gottcode.org/cutemaze/"
SRC_URI="http://gottcode.org/${PN}/${P}-src.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-svg:4"

src_configure() {
	qt4-r2_src_configure
}

src_install() {
	dogamesbin ${PN} || die
	dodoc ChangeLog README
	doicon icons/${PN}.png
	domenu icons/${PN}.desktop
	prepgamesdirs
}
