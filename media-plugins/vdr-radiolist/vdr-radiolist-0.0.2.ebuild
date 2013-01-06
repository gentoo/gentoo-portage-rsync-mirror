# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-radiolist/vdr-radiolist-0.0.2.ebuild,v 1.3 2007/07/10 23:08:59 mr_bones_ Exp $

inherit vdr-plugin

DESCRIPTION="VDR plugin: Filters channel list and only show the radio channels"
HOMEPAGE="http://vaasa.wi-bw.tfh-wildau.de/~pjuszack/digicam/#radiolist"
SRC_URI="http://194.95.44.38/~pjuszack/digicam/download/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=media-video/vdr-1.3.18"
