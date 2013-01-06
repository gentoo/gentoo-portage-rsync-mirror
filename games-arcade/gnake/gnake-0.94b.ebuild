# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/gnake/gnake-0.94b.ebuild,v 1.8 2009/12/24 12:53:26 volkmar Exp $

inherit games

DESCRIPTION="An ncurses-based Nibbles clone"
HOMEPAGE="http://lightless.org/gnake"
SRC_URI="http://lightless.org/files/Gnake.${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"
IUSE=""

DEPEND="sys-libs/ncurses"

S=${WORKDIR}/${PN}

src_compile() {
	emake LDLIBS=-lncurses gnake || die "emake failed"
}

src_install() {
	dogamesbin gnake || die "dogamesbin failed"
	dodoc README
	prepgamesdirs
}
