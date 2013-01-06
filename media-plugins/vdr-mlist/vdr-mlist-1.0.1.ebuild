# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-mlist/vdr-mlist-1.0.1.ebuild,v 1.3 2011/12/21 08:42:52 phajdan.jr Exp $

IUSE=""

inherit vdr-plugin eutils

DESCRIPTION="VDR plugin: Show a history of the last OSD message"
HOMEPAGE="http://www.joachim-wilke.de/?alias=vdr-mlist"
SRC_URI="http://joachim-wilke.de/vdr-mlist/${P}.tgz"
KEYWORDS="amd64 x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.3.30"
RDEPEND="${DEPEND}"
