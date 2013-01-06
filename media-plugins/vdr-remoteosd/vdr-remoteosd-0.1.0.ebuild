# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-remoteosd/vdr-remoteosd-0.1.0.ebuild,v 1.2 2010/12/22 23:52:41 hd_brummy Exp $

EAPI="2"

inherit vdr-plugin

DESCRIPTION="VDR: remoteosd PlugIn"
HOMEPAGE="http://vdr.schmirler.de/"
SRC_URI="http://vdr.schmirler.de/remoteosd/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.4.0
		>=media-plugins/vdr-svdrpservice-0.0.2"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i menu.h \
		-e 's-"../svdrpservice/svdrpservice.h"-<svdrpservice/svdrpservice.h>-'

	vdr-plugin_src_prepare
}
