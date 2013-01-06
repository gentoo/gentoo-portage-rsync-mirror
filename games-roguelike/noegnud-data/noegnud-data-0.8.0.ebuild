# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/noegnud-data/noegnud-data-0.8.0.ebuild,v 1.9 2008/03/07 20:17:00 wolf31o2 Exp $

inherit eutils games

# for more info on these themes visit:
# http://noegnud.sourceforge.net/downloads.shtml

# absurd itakura mazko abigabi geoduck lagged aoki falconseye
GUI_THEME=absurd
# falconseye nhs
SND_THEME=falconseye
DESCRIPTION="ultimate User Interface for nethack"
HOMEPAGE="http://noegnud.sourceforge.net/"
SRC_URI="mirror://sourceforge/noegnud/noegnud-${PV}_data-tileset-${GUI_THEME}.tar.bz2
	mirror://sourceforge/noegnud/noegnud-${PV}_data-sound-${SND_THEME}.tar.bz2"

LICENSE="nethack"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

S=${WORKDIR}/noegnud-${PV}/data

src_install() {
	dodir "${GAMES_DATADIR}/"noegnud_data
	cp -r * "${D}/${GAMES_DATADIR}"/noegnud_data/
	prepgamesdirs
}
