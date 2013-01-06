# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/openmortal/openmortal-0.7.ebuild,v 1.7 2007/02/07 06:40:28 nyhm Exp $

inherit eutils games

DESCRIPTION="A spoof of the famous Mortal Kombat game"
HOMEPAGE="http://openmortal.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer
	media-libs/sdl-ttf
	media-libs/sdl-net
	>=media-libs/freetype-2.1.0
	dev-lang/perl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}"-gcc41.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	newicon data/gfx/icon.png ${PN}.png
	make_desktop_entry ${PN} OpenMortal
	dodoc AUTHORS ChangeLog README TODO
	prepgamesdirs
}
