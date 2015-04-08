# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/descent1-maps/descent1-maps-1.0.ebuild,v 1.7 2014/05/18 20:43:00 ulm Exp $

inherit games

DESCRIPTION="Descent 1 third-party multiplayer maps"
HOMEPAGE="https://web.archive.org/web/20010608230948/http://www.d3community.com/d3net/spaz/"
SRC_URI="http://www.pooterman.com/pooterman.com/ftp/descent/levels/minerva.zip
	http://www.pooterman.com/pooterman.com/ftp/descent/levels/nysa.zip"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="x86"
IUSE=""
RESTRICT="mirror bindist"

RDEPEND="games-action/d1x-rebirth"

src_install () {
	insinto "${GAMES_DATADIR}/d1x"
	newins MINERVA.{RDL,rdl} || die
	newins MINERVA.{MSN,msn} || die
	newins NYSA.{RDL,rdl} || die
	newins NYSA.{MSN,msn} || die
	dodoc *.TXT
	prepgamesdirs
}
