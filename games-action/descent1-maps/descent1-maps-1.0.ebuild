# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/descent1-maps/descent1-maps-1.0.ebuild,v 1.6 2007/06/22 05:18:14 mr_bones_ Exp $

inherit games

DESCRIPTION="Descent 1 third-party multiplayer maps"
HOMEPAGE="http://d1x.warpcore.org"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="games-action/d1x-rebirth"

src_install () {
	insinto "${GAMES_DATADIR}/d1x"
	doins *.rdl *.msn || die
	dodoc *.txt
	prepgamesdirs
}
