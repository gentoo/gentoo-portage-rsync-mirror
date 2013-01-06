# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/qtads/qtads-2.1.3.ebuild,v 1.3 2012/06/08 12:12:27 phajdan.jr Exp $

EAPI=2
inherit eutils qt4-r2 games

DESCRIPTION="Multimedia interpreter for TADS text adventures"
HOMEPAGE="http://qtads.sourceforge.net"
SRC_URI="mirror://sourceforge/qtads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="x11-libs/qt-gui:4
	media-libs/libsdl[audio]
	media-libs/sdl-mixer[midi,vorbis]
	media-libs/sdl-sound[mp3]"

src_configure() {
	qt4-r2_src_configure
}

src_install() {
	dogamesbin qtads || die
	doman qtads.6
	dodoc AUTHORS BUGS NEWS README
	make_desktop_entry qtads QTads
	prepgamesdirs
}
