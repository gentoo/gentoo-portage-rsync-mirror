# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/xpired/xpired-1.22.ebuild,v 1.12 2012/09/01 06:12:11 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="A Sokoban-styled puzzle game with lots more action."
HOMEPAGE="http://xpired.sourceforge.net"
SRC_URI="mirror://sourceforge/xpired/${P}-linux_source.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND="media-libs/sdl-gfx
	media-libs/sdl-image[jpeg]
	media-libs/sdl-mixer[mod]"

S=${WORKDIR}/src

PATCHES=( "${FILESDIR}"/${P}-ldflags.patch )

src_compile() {
	emake \
		PREFIX=/usr/games \
		SHARE_PREFIX=/usr/share/games/xpired \
		|| die
}

src_install() {
	emake \
		PREFIX="${D}/usr/games" \
		SHARE_PREFIX="${D}/usr/share/games/${PN}" \
		install || die
	newicon img/icon.bmp ${PN}.bmp
	make_desktop_entry xpired Xpired /usr/share/pixmaps/${PN}.bmp
	make_desktop_entry xpiredit "Xpired Level Editor"
	prepgamesdirs
}
