# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/torrent/torrent-0.8.2.ebuild,v 1.6 2009/08/10 21:23:49 mr_bones_ Exp $

EAPI=2
inherit games

DESCRIPTION="Match rising tiles to score as many points as possible before the tiles touch the top of the board"
HOMEPAGE="http://www.shiftygames.com/torrent/torrent.html"
SRC_URI="http://www.shiftygames.com/torrent/${P}.tar.gz"

KEYWORDS="amd64 ppc x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=media-libs/libsdl-1.2.4
	>=media-libs/sdl-mixer-1.2
	>=media-libs/sdl-image-1.2
	media-libs/sdl-ttf"

src_prepare() {
	sed -i \
		-e 's/inline void SE_CheckEvents/void SE_CheckEvents/' \
		src/torrent.c \
		|| die "sed failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog
	prepgamesdirs
}
