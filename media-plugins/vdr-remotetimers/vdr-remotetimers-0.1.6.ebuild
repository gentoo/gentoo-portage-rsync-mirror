# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-remotetimers/vdr-remotetimers-0.1.6.ebuild,v 1.2 2012/05/06 19:21:49 hd_brummy Exp $

EAPI="4"

inherit vdr-plugin-2

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
	vdr-plugin-2_src_prepare

	sed -i svdrp.h \
		-e 's-../svdrpservice/svdrpservice.h-svdrpservice/svdrpservice.h-'
}
