# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/ninvaders/ninvaders-0.1.1.ebuild,v 1.6 2014/08/10 21:22:20 slyfox Exp $

inherit toolchain-funcs games

DESCRIPTION="ASCII space invaders clone"
HOMEPAGE="http://ninvaders.sourceforge.net/"
SRC_URI="mirror://sourceforge/ninvaders/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~x86-fbsd"
IUSE=""

DEPEND="sys-libs/ncurses"

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		|| die "emake failed"
}

src_install() {
	newgamesbin nInvaders ninvaders || die "newgamesbin failed"
	dodoc README
	prepgamesdirs
}
