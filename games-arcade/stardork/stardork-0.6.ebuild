# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/stardork/stardork-0.6.ebuild,v 1.7 2012/01/20 11:38:53 ssuominen Exp $

inherit toolchain-funcs games

DESCRIPTION="An ncurses-based space shooter"
HOMEPAGE="http://stardork.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 x86"
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
	dogamesbin ${PN} || die "dogamesbin failed"
	dodoc README
	prepgamesdirs
}
