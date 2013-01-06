# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/trailblazer/trailblazer-0.9.ebuild,v 1.6 2011/08/06 13:44:51 flameeyes Exp $

EAPI=2
inherit eutils games

DESCRIPTION="Guide a ball through a succession of levels while avoiding holes"
HOMEPAGE="http://www.autismuk.freeserve.co.uk/"
SRC_URI="http://www.autismuk.freeserve.co.uk/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86 ~x86-fbsd"
IUSE=""

DEPEND=">=media-libs/libsdl-1.2.7[video]"

src_prepare() {
	epatch "${FILESDIR}"/${P}-ldflags.patch \
		"${FILESDIR}"/${P}-underlink.patch

	sed -i \
		-e "s:-O2:${CFLAGS}:" \
		Makefile || die "sed Makefile failed"

	sed -i \
		-e "s:/usr/share/trailblazer/trail\.dat:${GAMES_DATADIR}/${PN}/trail.dat:" \
		-e "s:/usr/share/trailblazer/trail\.time:${GAMES_STATEDIR}/trail.time:" \
		map.c || die "sed map.c failed"
}

src_install() {
	dogamesbin trailblazer || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins trail.dat || die "doins failed"
	dodoc README

	dodir "${GAMES_STATEDIR}" \
		&& touch "${D}${GAMES_STATEDIR}/trail.time"

	prepgamesdirs
	fperms 660 "${GAMES_STATEDIR}/trail.time" || die
}
