# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/atakks/atakks-1.0.ebuild,v 1.9 2009/02/03 09:11:40 tupone Exp $

EAPI=2
inherit eutils games

MY_P=${P/-/_}
DESCRIPTION="A clone of Ataxx"
HOMEPAGE="http://team.gcu-squad.org/~fab"
# no version upstream
#SRC_URI="http://team.gcu-squad.org/~fab/down/${PN}.tgz"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND="media-libs/libsdl"

S=${WORKDIR}/${MY_P}

src_prepare() {
	# Modify game data paths
	sed -i \
		-e "s:SDL_LoadBMP(\":SDL_LoadBMP(\"${GAMES_DATADIR}/${PN}/:" \
		main.c || die "sed failed"

	epatch "${FILESDIR}"/${PV}-warnings.patch \
		"${FILESDIR}"/${P}-as-needed.patch
}

src_compile() {
	emake E_CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins *bmp || die "doins failed"
	newicon icon.bmp ${PN}.bmp
	make_desktop_entry ${PN} Atakks /usr/share/pixmaps/${PN}.bmp
	prepgamesdirs
}
