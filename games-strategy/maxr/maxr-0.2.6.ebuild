# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/maxr/maxr-0.2.6.ebuild,v 1.3 2009/11/17 21:45:29 volkmar Exp $

EAPI=2
inherit eutils games

DESCRIPTION="Mechanized Assault and Exploration Reloaded"
HOMEPAGE="http://www.maxr.org/"
SRC_URI="http://www.maxr.org/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-mixer[vorbis]
	media-libs/sdl-net"

src_install() {
	dogamesbin src/${PN} || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r data/* || die "doins failed"
	dodoc ABOUT CHANGELOG
	doicon data/maxr.png
	make_desktop_entry maxr "Mechanized Assault and Exploration Reloaded"
	prepgamesdirs
}
