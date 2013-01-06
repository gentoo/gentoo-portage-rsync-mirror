# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-remotetimers/vdr-remotetimers-0.1.4.ebuild,v 1.1 2011/03/05 11:22:09 hd_brummy Exp $

EAPI="3"

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

src_prepare() {
	vdr-plugin_src_prepare

	sed -i svdrp.h \
		-e 's-../svdrpservice/svdrpservice.h-svdrpservice/svdrpservice.h-'
}
