# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/biloba/biloba-0.9.3.ebuild,v 1.3 2012/11/17 20:31:52 ago Exp $

EAPI=2
inherit autotools eutils games

DESCRIPTION="a board game, up to 4 players, with AI and network."
HOMEPAGE="http://biloba.sourceforge.net/"
SRC_URI="mirror://sourceforge/biloba/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="media-libs/libsdl[X,video,audio]
	media-libs/sdl-image[png]
	media-libs/sdl-mixer"

src_prepare() {
	# X11 headers are checked but not used, everything is done through SDL
	epatch \
		"${FILESDIR}"/${P}-not-windows.patch \
		"${FILESDIR}"/${P}-no-X11-dep.patch

	# "missing" file is old, and warns about --run not being supported
	rm -f missing
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README
	newicon biloba_icon.png ${PN}.png
	make_desktop_entry biloba Biloba
	prepgamesdirs
}
