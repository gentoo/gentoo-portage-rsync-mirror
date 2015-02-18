# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/concentration/concentration-1.2-r1.ebuild,v 1.6 2015/02/18 20:20:08 tupone Exp $

EAPI=5
inherit eutils games

DESCRIPTION="The classic memory game with some new life"
HOMEPAGE="http://www.happypenguin.org/show?Concentration"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="media-libs/libsdl[sound,video]
	media-libs/sdl-mixer[vorbis]
	media-libs/sdl-image[png]
	media-libs/sdl-ttf"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}"/${P}-gentoo.patch )

src_install() {
	default
	newicon pics/set1/19.png ${PN}.png
	make_desktop_entry ${PN} Concentration
	prepgamesdirs
}
