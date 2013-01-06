# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/queen/queen-0-r1.ebuild,v 1.4 2011/02/13 17:55:41 armin76 Exp $

inherit eutils games

DESCRIPTION="Flight of the Amazon Queen - a 2D point-and-click adventure game set in the 1940s"
HOMEPAGE="http://scummvm.sourceforge.net/"
SRC_URI="mirror://sourceforge/scummvm/FOTAQ_Talkie.zip"

LICENSE="queen"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 x86"
IUSE=""

RDEPEND="games-engines/scummvm"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/FOTAQ_Talkie

src_install() {
	games_make_wrapper queen "scummvm -f -p \"${GAMES_DATADIR}/${PN}\" queen" .
	insinto "${GAMES_DATADIR}/${PN}"
	doins queen.1c || die "doins failed"
	dodoc readme.txt
	make_desktop_entry ${PN} "Flight of the Amazon Queen"
	prepgamesdirs
}
