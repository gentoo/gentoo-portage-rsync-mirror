# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/freesweep/freesweep-0.92.ebuild,v 1.5 2010/01/05 02:30:44 josejx Exp $

inherit games

DESCRIPTION="Console Minesweeper"
HOMEPAGE="http://freshmeat.net/projects/freesweep"
SRC_URI="http://www.upl.cs.wisc.edu/~hartmann/sweep/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~ppc-macos"
IUSE=""

DEPEND="sys-libs/ncurses"

src_install() {
	dogamesbin freesweep || die "dogamesbin failed"
	dodoc README
	doman freesweep.6
	prepgamesdirs
}
