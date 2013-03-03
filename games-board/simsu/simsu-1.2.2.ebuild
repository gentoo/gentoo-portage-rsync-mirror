# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/simsu/simsu-1.2.2.ebuild,v 1.4 2013/03/02 21:13:44 hwoarang Exp $

EAPI=2
inherit eutils qt4-r2 games

DESCRIPTION="A basic sudoku game"
HOMEPAGE="http://gottcode.org/simsu/"
SRC_URI="http://gottcode.org/${PN}/${P}-src.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-qt/qtgui:4"

src_configure() {
	eqmake4
}

src_install() {
	dogamesbin ${PN} || die
	dodoc ChangeLog
	doicon icons/hicolor/scalable/apps/${PN}.svg
	domenu icons/${PN}.desktop
	prepgamesdirs
}
