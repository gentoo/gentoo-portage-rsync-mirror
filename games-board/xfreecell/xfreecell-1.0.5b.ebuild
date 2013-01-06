# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/xfreecell/xfreecell-1.0.5b.ebuild,v 1.14 2012/12/11 06:30:54 ulm Exp $

inherit eutils games

DESCRIPTION="A freecell game for X"
HOMEPAGE="http://www2.giganet.net/~nakayama/"
SRC_URI="http://www2.giganet.net/~nakayama/${P}.tgz
	http://www2.giganet.net/~nakayama/MSNumbers.gz"

LICENSE="HPND"
SLOT="0"
KEYWORDS="amd64 ~ppc ppc64 x86"
IUSE=""

RDEPEND="x11-libs/libXext"
DEPEND="${RDEPEND}
	x11-proto/xextproto"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch \
		"${FILESDIR}"/${P}-gentoo.patch \
		"${FILESDIR}"/${P}-gcc43.patch
}

src_install() {
	dogamesbin xfreecell || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins "${WORKDIR}"/MSNumbers || die "doins failed"
	dodoc CHANGES README mshuffle.txt
	doman xfreecell.6
	prepgamesdirs
}
