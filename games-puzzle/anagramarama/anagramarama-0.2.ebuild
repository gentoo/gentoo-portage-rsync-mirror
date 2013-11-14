# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/anagramarama/anagramarama-0.2.ebuild,v 1.9 2013/11/14 22:02:36 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="Create as many words as you can before the time runs out"
HOMEPAGE="http://www.coralquest.com/anagramarama/"
SRC_URI="http://www.omega.clara.net/anagramarama/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=">=media-libs/libsdl-1.2
	>=media-libs/sdl-mixer-1.2
	>=media-libs/sdl-image-1.2"
RDEPEND="${DEPEND}
	sys-apps/miscfiles"

S=${WORKDIR}/${PN}

src_prepare() {
	sed -i \
		-e "s:wordlist.txt:${GAMES_DATADIR}\/${PN}\/wordlist.txt:" \
		-e "s:\"audio\/:\"${GAMES_DATADIR}\/${PN}\/audio\/:" \
		-e "s:\"images\/:\"${GAMES_DATADIR}\/${PN}\/images\/:" \
		src/{ag.c,dlb.c} \
		|| die "sed failed"
	rm -rf $(find . -type d -name CVS)
	epatch "${FILESDIR}"/${P}-gentoo.patch
}

src_install() {
	newgamesbin ag ${PN} || die "newgamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins wordlist.txt || die "doins failed"
	doins -r images/ audio/ || die "doins failed"
	dodoc readme
	prepgamesdirs
}
