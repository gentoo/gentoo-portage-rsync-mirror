# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/xye/xye-0.12.0.ebuild,v 1.4 2012/10/17 08:05:17 tupone Exp $

EAPI=4
inherit autotools eutils games

DESCRIPTION="Free version of the classic game Kye"
HOMEPAGE="http://xye.sourceforge.net/"
SRC_URI="mirror://sourceforge/xye/${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="media-libs/libsdl[video]
	media-libs/sdl-ttf
	media-libs/sdl-image[png]
	media-fonts/dejavu"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc47.patch
	sed -i -e '/^xye_LDFLAGS/d' Makefile.am || die
	eautoreconf
}

src_install() {
	dogamesbin "${PN}"
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r levels res
	rm -f "${D}${GAMES_DATADIR}/${PN}"/res/DejaVuSans*
	dosym /usr/share/fonts/dejavu/DejaVuSans.ttf "${GAMES_DATADIR}/${PN}"/res/
	dosym /usr/share/fonts/dejavu/DejaVuSans-Bold.ttf "${GAMES_DATADIR}/${PN}"/res/
	dodoc readme.txt GAMEINTRO.txt AUTHORS ChangeLog README NEWS
	doicon xye.svg
	make_desktop_entry ${PN} Xye
	prepgamesdirs
}
