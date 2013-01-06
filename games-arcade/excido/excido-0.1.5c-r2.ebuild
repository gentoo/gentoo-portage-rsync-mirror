# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/excido/excido-0.1.5c-r2.ebuild,v 1.4 2011/08/07 17:11:08 armin76 Exp $

EAPI=2
inherit games

DESCRIPTION="A fast paced action game"
HOMEPAGE="http://icculus.org/excido/"
SRC_URI="http://icculus.org/excido/${P}-src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND="dev-games/physfs
	media-libs/libsdl[opengl]
	media-libs/sdl-mixer
	media-libs/sdl-ttf
	media-libs/sdl-image[png]
	media-libs/openal
	media-libs/freealut"

PATCHES=( "${FILESDIR}"/${P}-freealut.patch "${FILESDIR}"/${P}-build.patch )

src_compile() {
	emake DATADIR="${GAMES_DATADIR}"/${PN}/ || die "emake failed"
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins data/* || die "doins failed"
	dodoc BUGS CHANGELOG HACKING README TODO \
		keyguide.txt data/CREDITS data/*.txt
	prepgamesdirs
}
