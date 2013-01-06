# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/hexamine/hexamine-0.2.1.ebuild,v 1.3 2010/01/24 23:11:02 ranger Exp $

inherit games

DESCRIPTION="Hexagonal Minesweeper"
HOMEPAGE="http://sourceforge.net/projects/hexamine"
SRC_URI="mirror://sourceforge/hexamine/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

RDEPEND="media-libs/libsdl
	dev-python/pygame"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Modify game data directory
	sed -i \
		-e "s:\`dirname \$0\`:${GAMES_DATADIR}/${PN}:" \
		-e "s:\./hexamine:exec python &:" \
		hexamine || die "sed failed"
}

src_install() {
	dogamesbin hexamine || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r hexamine.* skins || die "doins failed"
	dodoc ABOUT README
	prepgamesdirs
}
