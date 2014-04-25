# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-reaction/quake3-reaction-3.2.ebuild,v 1.5 2014/04/25 18:37:01 ulm Exp $

EAPI=2

MOD_DESC="port of Action Quake 2 to Quake 3: Arena"
MOD_NAME="Reaction"
MOD_DIR="rq3"
MOD_ICON="reaction-4.ico"

inherit games games-mods

HOMEPAGE="http://www.rq3.com/"
SRC_URI="http://www.rq3.com/ReactionQuake3-v${PV}-Full.zip"

LICENSE="all-rights-reserved"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="dedicated opengl"
