# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/doom3-eventhorizon/doom3-eventhorizon-1.3.ebuild,v 1.2 2009/10/10 17:10:38 nyhm Exp $

EAPI=2

MOD_DESC="single-player mission based on the Event Horizon film"
MOD_NAME="Event Horizon"
MOD_DIR="eventhorizon"

inherit games games-mods

HOMEPAGE="http://doom3.filefront.com/file/Event_Horizon_XV;91253"
SRC_URI="ftp://files.mhgaming.com/doom3/mods/event_horizon_xv_${PV}.zip"

LICENSE="as-is"
KEYWORDS="amd64 x86"
IUSE="dedicated opengl"

src_prepare() {
	mv -f event_horizon* ${MOD_DIR} || die
}
