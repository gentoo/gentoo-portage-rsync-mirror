# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/egoboo/egoboo-2.7.4.ebuild,v 1.9 2011/06/18 18:34:57 tupone Exp $

EAPI=2
inherit eutils games

DESCRIPTION="A 3d dungeon crawling adventure in the spirit of NetHack"
HOMEPAGE="http://egoboo.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="virtual/opengl
	virtual/glu
	media-libs/libsdl[video]
	media-libs/sdl-image
	media-libs/sdl-mixer[vorbis]
	media-libs/sdl-ttf
	net-libs/enet:0"

src_prepare() {
	epatch "${FILESDIR}"/${P}-enet.patch \
		"${FILESDIR}"/${P}-underlink.patch
	sed -i \
		-e "s:\${EGOBOO_PREFIX}/share:${GAMES_DATADIR}:" \
		-e "s:\${EGOBOO_PREFIX}/libexec:$(games_get_libdir):" \
		game/egoboo.sh || die "sed failed"
}

src_compile() {
	emake -C game -f Makefile.unix || die "emake failed"
}

src_install() {
	dodoc Changelog.txt doc/* || die "dodoc failed"

	exeinto "$(games_get_libdir)"
	doexe game/${PN} || die "doexe failed"

	insinto "${GAMES_DATADIR}/${PN}"
	doins -r basicdat modules players controls.txt setup.txt \
		|| die "doins failed"

	newgamesbin game/egoboo.sh ${PN} || die "newgamesbin failed"

	newicon basicdat/icon.bmp ${PN}.bmp
	make_desktop_entry ${PN} Egoboo /usr/share/pixmaps/${PN}.bmp

	prepgamesdirs
}
