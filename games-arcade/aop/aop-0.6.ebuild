# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/aop/aop-0.6.ebuild,v 1.13 2010/02/20 20:57:51 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="Ambassador of Pain is a curses based game with only 64 lines of code."
HOMEPAGE="http://raffi.at/view/code/aop"
SRC_URI="http://www.raffi.at/code/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="sys-libs/ncurses"

src_prepare() {
	sed -i \
		-e "s#/usr/local/share#${GAMES_DATADIR}#" \
		aop.c \
		|| die "sed failed"
	epatch "${FILESDIR}"/${P}-as-needed.patch
}

src_install() {
	dogamesbin aop || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins aop-level-*.txt || die "doins failed"
	prepgamesdirs
}
