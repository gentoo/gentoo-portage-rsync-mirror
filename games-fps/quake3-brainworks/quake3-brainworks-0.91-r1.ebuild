# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-brainworks/quake3-brainworks-0.91-r1.ebuild,v 1.4 2009/10/10 17:23:44 nyhm Exp $

EAPI=2

MOD_DESC="Enhanced AI for the Quake III Bots"
MOD_NAME="Brainworks"
MOD_DIR="brainworks"

inherit games games-mods

HOMEPAGE="http://www.planetquake.com/artofwar"
SRC_URI="brainworks-0-91.zip"

LICENSE="freedist"
KEYWORDS="amd64 ~ppc x86"
IUSE="dedicated opengl"
RESTRICT="strip mirror fetch"

pkg_nofetch() {
	einfo "Go to http://artofwar.planetquake.gamespy.com/downloads.html and"
	einfo "download ${A}, then put it into ${DISTDIR}."
}
