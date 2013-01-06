# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-remotetimers/vdr-remotetimers-0.1.3.ebuild,v 1.1 2010/02/23 21:21:49 zzam Exp $

inherit vdr-plugin

DESCRIPTION="VDR plugin: edit timers on remote vdr instances"
HOMEPAGE="http://vdr.schmirler.de/"
SRC_URI="http://vdr.schmirler.de/${PN#vdr-}/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.4.0
		>=media-plugins/vdr-svdrpservice-0.0.3"
RDEPEND="${DEPEND}"

PATCHES=("${FILESDIR}/${PN}-0.1.1-Makefile.diff")

src_unpack() {
	vdr-plugin_src_unpack unpack
	cd "${S}"

	sed -i svdrp.h \
		-e 's-../svdrpservice/svdrpservice.h-svdrpservice/svdrpservice.h-'

	vdr-plugin_src_unpack all_but_unpack
}
