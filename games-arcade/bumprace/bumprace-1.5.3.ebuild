# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/bumprace/bumprace-1.5.3.ebuild,v 1.4 2011/02/25 21:48:05 signals Exp $

inherit eutils games

DESCRIPTION="simple arcade racing game"
HOMEPAGE="http://www.linux-games.com/bumprace/"
SRC_URI="http://user.cs.tu-berlin.de/~karlb/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~sparc x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-mixer
	virtual/jpeg
	media-libs/sdl-image"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog FAQ README
	make_desktop_entry bumprace BumpRace
	prepgamesdirs
}
