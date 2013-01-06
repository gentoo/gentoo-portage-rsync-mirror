# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/spacerider/spacerider-0.13.ebuild,v 1.9 2010/10/29 08:31:19 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="space-shooter written in C++, using the SDL"
HOMEPAGE="http://www.hackl.dhs.org/spacerider/"
SRC_URI="mirror://gentoo/${P}.tar.bz2" # stupid php script

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND="media-libs/sdl-gfx
	media-libs/sdl-mixer
	media-libs/sdl-image[jpeg]
	media-libs/sdl-net
	media-libs/sdl-ttf"

src_prepare() {
	epatch "${FILESDIR}/${P}"-gentoo.patch \
		"${FILESDIR}/${P}"-gcc41.patch \
		"${FILESDIR}"/${P}-ovflfix.patch
	sed -i \
		-e "s:/usr/share/games/spacerider:${GAMES_DATADIR}/${PN}:" \
		globals.cpp \
		|| die "sed failed"
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r data || die "doins failed"
	dodoc AUTHORS
	newman ${PN}.{1,6}
	prepgamesdirs
}
