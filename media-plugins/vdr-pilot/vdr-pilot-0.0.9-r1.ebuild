# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-pilot/vdr-pilot-0.0.9-r1.ebuild,v 1.3 2009/03/12 20:47:58 zzam Exp $

IUSE=""
inherit vdr-plugin eutils

DESCRIPTION="VDR plugin: Another way for viewing EPG and zap to channels"
HOMEPAGE="http://famillejacques.free.fr/vdr/"
SRC_URI="http://famillejacques.free.fr/vdr/pilot/${P}.tgz"

KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.4.1"

src_unpack() {
	vdr-plugin_src_unpack unpack
	epatch "${FILESDIR}/${P}-german.diff"
	epatch "${FILESDIR}/${P}-gcc-4.1.diff"
	if has_version ">=media-video/vdr-1.6.0"; then
		epatch "${FILESDIR}/${P}-vdr-1.6.0.diff"
	fi
	vdr-plugin_src_unpack all_but_unpack
}
