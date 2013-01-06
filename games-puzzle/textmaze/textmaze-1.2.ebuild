# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/textmaze/textmaze-1.2.ebuild,v 1.5 2009/11/16 14:50:25 volkmar Exp $

EAPI=2
inherit games

MY_P=${PN}_v${PV}
DESCRIPTION="An ncurses-based maze solving game written in Perl"
HOMEPAGE="http://freshmeat.net/projects/textmaze/"
SRC_URI="http://www.robobunny.com/projects/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

RDEPEND="dev-perl/Curses"

S=${WORKDIR}/TextMaze

src_prepare() {
	sed -i \
		-e "s#/usr/local/bin/perl#/usr/bin/perl#" \
		textmaze \
		|| die "sed failed"
}

src_install() {
	dogamesbin textmaze || die "dogamesbin failed"
	dodoc CHANGES README
	prepgamesdirs
}
