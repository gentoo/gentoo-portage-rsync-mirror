# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/sirius/sirius-0.8.0.ebuild,v 1.9 2010/08/16 19:58:24 mr_bones_ Exp $

EAPI=2
inherit games

DESCRIPTION="A program for playing the game of othello/reversi"
HOMEPAGE="http://sirius.bitvis.nu/"
SRC_URI="http://sirius.bitvis.nu/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="nls"

RDEPEND="x11-libs/gtk+:2
	gnome-base/gconf:2
	gnome-base/libgnomeui
	gnome-base/libgnomecanvas
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_prepare() {
	sed -i '/-g -O3/d' configure || die "sed failed"
}

src_configure() {
	egamesconf \
		--datadir=/usr/share \
		$(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS BUGS ChangeLog README
	prepgamesdirs
}
