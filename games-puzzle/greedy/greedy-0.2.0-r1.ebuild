# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/greedy/greedy-0.2.0-r1.ebuild,v 1.10 2009/05/31 23:40:39 ranger Exp $

inherit toolchain-funcs games

DESCRIPTION="fun little ncurses puzzle game"
HOMEPAGE="http://www.kotinet.com/juhamattin/linux/index.html"
SRC_URI="http://www.kotinet.com/juhamattin/linux/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86"
IUSE=""

DEPEND="sys-libs/ncurses"

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -f Makefile
}

src_compile() {
	emake CC="$(tc-getCC)" LDLIBS=-lncurses ${PN} || die "emake failed"
}

src_install() {
	# It wants a scores file.  We need to touch one and install it.
	touch greedy.scores
	insinto "${GAMES_STATEDIR}"
	doins greedy.scores || die "doins failed"

	dogamesbin greedy || die "dogamesbin failed"
	dodoc CHANGES README TODO

	prepgamesdirs
	# We need to set the permissions correctly
	fperms 664 "${GAMES_STATEDIR}/greedy.scores" || die "fperms failed"
}
