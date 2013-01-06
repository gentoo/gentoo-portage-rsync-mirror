# Copyright 2003-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-mlist/vdr-mlist-0.0.3.ebuild,v 1.4 2008/04/28 08:49:47 zzam Exp $

IUSE=""

inherit vdr-plugin eutils

DESCRIPTION="VDR plugin: Show a history of the last OSD message"
HOMEPAGE="http://www.joachim-wilke.de/?alias=vdr-mlist"
SRC_URI="http://joachim-wilke.de/vdr-mlist/${P}.tgz"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.3.30"
