# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/stardork/stardork-0.7.ebuild,v 1.2 2012/01/28 14:55:58 phajdan.jr Exp $

EAPI=2
inherit toolchain-funcs games

DESCRIPTION="An ncurses-based space shooter"
HOMEPAGE="http://stardork.sourceforge.net/"
SRC_URI="mirror://sourceforge/stardork/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 x86"
IUSE=""

DEPEND="sys-libs/ncurses"

src_prepare() {
	rm -f Makefile
}

src_compile() {
	emake CC="$(tc-getCC)" LDLIBS=-lncurses ${PN} || die
}

src_install() {
	dogamesbin ${PN} || die
	dodoc README
	prepgamesdirs
}
