# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/sirius/sirius-0.8.0.ebuild,v 1.11 2015/02/06 13:42:54 ago Exp $

EAPI=5
inherit autotools games

DESCRIPTION="A program for playing the game of othello/reversi"
HOMEPAGE="http://sirius.bitvis.nu/"
SRC_URI="http://sirius.bitvis.nu/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="nls"

RDEPEND="x11-libs/gtk+:2
	gnome-base/gconf:2
	gnome-base/libgnomeui
	gnome-base/libgnomecanvas
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_prepare() {
	sed -i -e '/-g -O3/d' configure.in || die
	sed -i \
		-e '/Icon/s/\.png//' \
		-e '/Categories/s/Application;//' \
		sirius.desktop.in || die
	eautoreconf
}

src_configure() {
	egamesconf \
		--datadir=/usr/share \
		$(use_enable nls)
}

src_install() {
	default
	prepgamesdirs
}
