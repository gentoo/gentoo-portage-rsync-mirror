# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/wakkabox/wakkabox-1.1.0.ebuild,v 1.8 2005/10/31 08:55:43 mr_bones_ Exp $

inherit games

DESCRIPTION="A simple block-pushing game"
HOMEPAGE="http://kenn.frap.net/wakkabox/"
SRC_URI="http://kenn.frap.net/wakkabox/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

DEPEND=">=media-libs/libsdl-1.0.1"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS NEWS README
	prepgamesdirs
}
