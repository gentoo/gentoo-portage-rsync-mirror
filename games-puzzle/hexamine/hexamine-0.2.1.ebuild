# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/hexamine/hexamine-0.2.1.ebuild,v 1.4 2015/02/11 06:31:37 mr_bones_ Exp $

EAPI=5
inherit games

DESCRIPTION="Hexagonal Minesweeper"
HOMEPAGE="http://sourceforge.net/projects/hexamine"
SRC_URI="mirror://sourceforge/hexamine/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

RDEPEND="dev-python/pygame"

S=${WORKDIR}/${PN}

src_prepare() {
	# Modify game data directory
	sed -i \
		-e "s:\`dirname \$0\`:${GAMES_DATADIR}/${PN}:" \
		-e "s:\./hexamine:exec python &:" \
		hexamine || die
}

src_install() {
	dogamesbin hexamine
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r hexamine.* skins
	dodoc ABOUT README
	prepgamesdirs
}
