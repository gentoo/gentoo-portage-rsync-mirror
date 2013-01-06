# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/tong/tong-1.0.ebuild,v 1.6 2009/04/06 21:57:42 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="Tetris and Pong in the same place at the same time"
HOMEPAGE="http://www.nongnu.org/tong/"
SRC_URI="http://www.nongnu.org/tong/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-image[png]
	media-libs/sdl-mixer[vorbis]"

src_prepare() {
	epatch \
		"${FILESDIR}/${P}-makefile.patch" \
		"${FILESDIR}/${P}-fps.patch"
	sed -i \
		-e "s:\"media/:\"${GAMES_DATADIR}/${PN}/media/:" \
		media.cpp option.cpp option.h pong.cpp tetris.cpp text.cpp \
		|| die "sed failed"
	cp media/icon.png "${T}/${PN}.png"
}

src_install() {
	dogamesbin tong || die "dogamesbin failed"
	dodir "${GAMES_DATADIR}/${PN}"
	cp -r media/ "${D}/${GAMES_DATADIR}/${PN}" || die "cp failed"
	dodoc CHANGELOG README making-of.txt CREDITS

	make_desktop_entry tong TONG
	doicon "${T}/${PN}.png"
	prepgamesdirs
}
