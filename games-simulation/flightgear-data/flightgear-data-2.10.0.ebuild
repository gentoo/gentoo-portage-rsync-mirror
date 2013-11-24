# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/flightgear-data/flightgear-data-2.10.0.ebuild,v 1.2 2013/11/24 08:10:48 pacho Exp $

EAPI=5

inherit games

DESCRIPTION="FlightGear data files"
HOMEPAGE="http://www.flightgear.org/"
SRC_URI="mirror://flightgear/Shared/FlightGear-data-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE=""

# data files split to separate package since 2.10.0
RDEPEND="
	!<games-simulation/flightgear-2.10.0
"

S=${WORKDIR}
GAMES_SHOW_WARNING=NO

src_install() {
	insinto "${GAMES_DATADIR}"/flightgear
	doins -r data/*
	prepgamesdirs
}
