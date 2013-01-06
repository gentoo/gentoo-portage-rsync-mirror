# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/pydance-songs/pydance-songs-20040410.ebuild,v 1.7 2010/02/08 21:58:42 ulm Exp $

inherit games

DESCRIPTION="Music for the pyDDR game"
HOMEPAGE="http://icculus.org/pyddr/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"
IUSE=""

RDEPEND="games-arcade/pydance"

S="${WORKDIR}"

src_install() {
	insinto "${GAMES_DATADIR}/pydance/songs"
	cd "${S}"
	doins * || die
	prepgamesdirs
}
