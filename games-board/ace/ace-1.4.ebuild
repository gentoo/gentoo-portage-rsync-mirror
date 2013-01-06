# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/ace/ace-1.4.ebuild,v 1.6 2013/01/05 12:41:53 ago Exp $

EAPI=2
inherit autotools base eutils games

DESCRIPTION="DJ Delorie's Ace of Penguins solitaire games"
HOMEPAGE="http://www.delorie.com/store/ace/"
SRC_URI="http://www.delorie.com/store/ace/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc ~x86"
IUSE=""

RDEPEND="x11-libs/libX11
	media-libs/libpng:0"
DEPEND="${RDEPEND}
	x11-proto/xproto"

PATCHES=( "${FILESDIR}"/${P}-no-xpm.patch "${FILESDIR}"/${P}-libpng15.patch "${FILESDIR}"/${P}-gold.patch "${FILESDIR}"/${P}-CC.patch "${FILESDIR}"/${P}-clang.patch )

src_prepare() {
	base_src_prepare
	eautoreconf
}

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		--disable-static \
		--program-prefix=ace-
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
	dohtml docs/*
	newicon docs/as.gif ${PN}.gif
	cd "${D}${GAMES_BINDIR}" && {
		local p
		for p in *
		do
			make_desktop_entry $p "Ace ${p/ace-/}" /usr/share/pixmaps/${PN}.gif
		done
	}
	prepgamesdirs
}
