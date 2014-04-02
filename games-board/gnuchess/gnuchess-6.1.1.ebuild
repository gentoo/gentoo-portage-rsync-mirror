# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gnuchess/gnuchess-6.1.1.ebuild,v 1.2 2014/04/02 19:14:40 nimiux Exp $

EAPI=5
inherit flag-o-matic games

DESCRIPTION="Console based chess interface"
HOMEPAGE="http://www.gnu.org/software/chess/chess.html"
SRC_URI="mirror://gnu/chess/${P}.tar.gz"

KEYWORDS="amd64 ~arm ~ppc ~ppc64 ~x86"
LICENSE="GPL-3"
SLOT="0"
IUSE=""

src_configure() {
	strip-flags # bug #199097
	egamesconf --without-readline # bug 491088
}

src_install () {
	default
	prepgamesdirs
}
