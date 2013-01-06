# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/missile/missile-1.0.1.ebuild,v 1.16 2010/10/11 22:02:19 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="The game Missile Command for Linux"
HOMEPAGE="http://missile.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc sparc x86"
IUSE=""

DEPEND="media-libs/libsdl[audio,video]
	media-libs/sdl-image[png]
	media-libs/sdl-mixer"

src_prepare() {
	epatch "${FILESDIR}"/${P}-ldflags.patch
	sed -i \
		-e '/^CC/d' \
		-e "s:\$(game_prefix)/\$(game_data):${GAMES_DATADIR}/${PN}:" \
		-e "s/-O2/${CFLAGS}/" \
		Makefile \
		|| die "sed failed"
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r data/* || die "doins failed"
	newicon icons/${PN}_icon_black.png ${PN}.png
	make_desktop_entry ${PN} "Missile Command"
	dodoc README
	prepgamesdirs
}
