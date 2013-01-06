# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gnuchess-book/gnuchess-book-1.01.ebuild,v 1.5 2012/09/30 18:03:35 armin76 Exp $

inherit games

DESCRIPTION="Opening book for gnuchess"
HOMEPAGE="http://www.gnu.org/software/chess/chess.html"
SRC_URI="mirror://gnu/chess/book_${PV}.pgn.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""
RESTRICT="userpriv" # bug #112898

DEPEND="<games-board/gnuchess-5.9"

S=${WORKDIR}

src_compile() {
	echo -e "book add book_${PV}.pgn"$'\n'"quit" | "${GAMES_BINDIR}"/gnuchess \
		|| die "generation failed"
}

src_install() {
	insinto "${GAMES_DATADIR}/gnuchess"
	doins book.dat || die "doins failed"
	prepgamesdirs
}
