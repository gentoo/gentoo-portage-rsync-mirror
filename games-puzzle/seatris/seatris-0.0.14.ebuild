# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/seatris/seatris-0.0.14.ebuild,v 1.10 2009/02/10 11:55:04 tupone Exp $

EAPI=2
inherit eutils games

DESCRIPTION="A color ncurses tetris clone"
HOMEPAGE="http://www.earth.li/projectpurple/progs/seatris.html"
SRC_URI="http://www.earth.li/projectpurple/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ppc64 x86"
IUSE=""

DEPEND="sys-libs/ncurses"

src_prepare() {
	sed -i \
		-e "s:/var/lib/games:${GAMES_STATEDIR}:" \
		scoring.h seatris.6 \
		|| die "sed failed"
	epatch "${FILESDIR}"/${P}-as-needed.patch
}

src_install () {
	dogamesbin seatris || die "dogamesbin failed"
	doman seatris.6
	dodoc ACKNOWLEDGEMENTS HISTORY README TODO example.seatrisrc
	dodir "${GAMES_STATEDIR}"
	touch "${D}${GAMES_STATEDIR}/seatris.score"
	fperms 660 "${GAMES_STATEDIR}/seatris.score"
	prepgamesdirs
}
