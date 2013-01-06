# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/berusky/berusky-1.5.2.ebuild,v 1.1 2012/11/15 22:46:06 mr_bones_ Exp $

EAPI=4
inherit autotools eutils games

DATAFILE=${PN}-data-${PV}
DESCRIPTION="free logic game based on an ancient puzzle named Sokoban."
HOMEPAGE="http://anakreon.cz/?q=node/1"
SRC_URI="http://www.anakreon.cz/download/${P}.tar.gz
	http://www.anakreon.cz/download/${DATAFILE}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/libsdl[video]
	media-libs/sdl-image[png]
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	mv ../${DATAFILE}/{berusky.ini,GameData,Graphics,Levels} . || die
	epatch "${FILESDIR}"/${P}-gentoo.patch
	sed -i \
		-e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}/${PN}:" \
		-e "s:@GENTOO_BINDIR@:${GAMES_BINDIR}:" \
		src/defines.h berusky.ini \
		|| die
	eautoreconf
}

src_install() {
	default
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r berusky.ini GameData Graphics Levels || die
	make_desktop_entry ${PN}
	prepgamesdirs
}
