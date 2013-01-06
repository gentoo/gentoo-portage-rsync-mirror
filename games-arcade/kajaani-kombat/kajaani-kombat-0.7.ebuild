# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/kajaani-kombat/kajaani-kombat-0.7.ebuild,v 1.8 2010/10/18 16:21:00 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="A rampart-like game set in space"
HOMEPAGE="http://kombat.kajaani.net/"
SRC_URI="http://kombat.kajaani.net/dl/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"
IUSE=""

DEPEND="media-libs/libsdl[audio,video]
	media-libs/sdl-net
	media-libs/sdl-image[png]
	media-libs/sdl-ttf
	media-libs/sdl-mixer[vorbis]
	sys-libs/ncurses
	sys-libs/readline"

src_prepare() {
	epatch "${FILESDIR}/${PV}-makefile.patch" \
		"${FILESDIR}"/${P}-ldflags.patch
	sed -i \
		-e "s:GENTOODIR:${GAMES_DATADIR}/${PN}/:" \
		Makefile \
		|| die "sed failed"
	sed -i \
		-e 's/IMG_Load/img_load/' \
		gui_screens.cpp \
		|| die "sed failed"
}

src_install() {
	dogamesbin kajaani-kombat || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins *.{png,ttf,ogg} || die "doins failed"
	dodoc AUTHORS ChangeLog README
	doman kajaani-kombat.6
	prepgamesdirs
}
