# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/hangman/hangman-0.9.2.ebuild,v 1.12 2010/05/28 14:54:04 tupone Exp $

EAPI=2
inherit eutils games

DESCRIPTION="The classic word guessing game"
HOMEPAGE="http://www.shiftygames.com/hangman/hangman.html"
SRC_URI="http://www.shiftygames.com/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE=""

DEPEND="!games-misc/bsd-games
	media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-image
	media-libs/sdl-ttf"
RDEPEND="${DEPEND}
	sys-apps/miscfiles"

src_prepare() {
	sed -i \
		-e 's/inline void SE_CheckEvents/void SE_CheckEvents/' \
		src/hangman.c \
		|| die "sed failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	newicon pics/noose.png ${PN}.png
	make_desktop_entry ${PN} Hangman
	prepgamesdirs
}
