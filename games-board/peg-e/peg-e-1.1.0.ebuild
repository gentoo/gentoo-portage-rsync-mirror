# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/peg-e/peg-e-1.1.0.ebuild,v 1.3 2011/11/02 01:36:41 mr_bones_ Exp $

EAPI=2
inherit eutils qt4-r2 games

DESCRIPTION="A peg solitaire game"
HOMEPAGE="http://gottcode.org/peg-e/"
SRC_URI="http://gottcode.org/${PN}/${P}-src.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="x11-libs/qt-gui:4"

src_configure() {
	eqmake4
}

src_install() {
	dogamesbin ${PN} || die
	doicon icons/${PN}.png
	domenu icons/${PN}.desktop
	dodoc README
	prepgamesdirs
}
