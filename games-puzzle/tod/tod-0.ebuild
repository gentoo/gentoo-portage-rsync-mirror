# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/tod/tod-0.ebuild,v 1.7 2011/10/14 06:18:33 vapier Exp $

EAPI="2"

inherit eutils games

DESCRIPTION="Tetanus On Drugs simulates playing a Tetris clone under the influence of hallucinogenic drugs"
HOMEPAGE="http://www.pineight.com/tod/"
SRC_URI="http://www.pineight.com/pc/win${PN}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

RDEPEND="media-libs/allegro:0[X]"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}

src_prepare() {
	epatch "${FILESDIR}"/${P}-makefile.patch
	sed -i \
		-e "s:idltd\.dat:${GAMES_DATADIR}/${PN}/idltd.dat:" \
		rec.c || die "sed failed"
}

src_install() {
	newgamesbin tod-debug.exe tod || die
	insinto "${GAMES_DATADIR}"/${PN}
	doins idltd.dat || die
	dodoc readme.txt
	prepgamesdirs
}
