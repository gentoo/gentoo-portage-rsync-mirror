# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/sex/sex-1.0.ebuild,v 1.19 2010/01/03 12:09:26 fauli Exp $

inherit games

DESCRIPTION="Spouts silly mad-lib-style porn-like text"
HOMEPAGE="http://spatula.net/software/sex/"
SRC_URI="http://spatula.net/software/sex/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

src_unpack() {
	unpack ${A}
	rm -f "${S}"/Makefile
}

src_compile() {
	emake sex || die "emake failed"
}

src_install() {
	dogamesbin sex || die "dogamesbin failed"
	doman sex.6
	dodoc README
	prepgamesdirs
}
