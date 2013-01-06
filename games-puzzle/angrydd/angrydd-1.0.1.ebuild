# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/angrydd/angrydd-1.0.1.ebuild,v 1.7 2010/09/09 16:43:17 mr_bones_ Exp $

EAPI=2
PYTHON_DEPEND="2"
inherit eutils python games

DESCRIPTION="Angry, Drunken Dwarves, a falling blocks game similar to Puzzle Fighter"
HOMEPAGE="http://www.sacredchao.net/~piman/angrydd/"
SRC_URI="http://www.sacredchao.net/~piman/angrydd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND=">=dev-python/pygame-1.6.2
	>=dev-lang/python-2.3"

pkg_setup() {
	python_set_active_version 2
	games_pkg_setup
}

src_prepare() {
	python_convert_shebangs -r 2 .
}

src_install() {
	emake \
		DESTDIR="${D}" \
		PREFIX="${GAMES_DATADIR}" \
		TO="${PN}" \
		install || die
	rm -rf "${D}${GAMES_DATADIR}/games" "${D}${GAMES_DATADIR}/share"
	dodir "${GAMES_BINDIR}"
	dosym "${GAMES_DATADIR}/${PN}/angrydd.py" "${GAMES_BINDIR}/${PN}"
	doman angrydd.6
	dodoc README TODO HACKING

	doicon angrydd.png
	make_desktop_entry angrydd "Angry, Drunken Dwarves"

	prepgamesdirs
}
