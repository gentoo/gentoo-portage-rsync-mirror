# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-wirbelscan/vdr-wirbelscan-0.0.7.ebuild,v 1.1 2011/09/15 14:18:25 hd_brummy Exp $

EAPI=3

inherit vdr-plugin

DESCRIPTION="VDR Plugin: Scan for channels on DVB-? and on PVR*-Cards"
HOMEPAGE="http://wirbel.htpc-forum.de/wirbelscan/index2.html"
SRC_URI="http://wirbel.htpc-forum.de/wirbelscan/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="media-video/vdr
	!<media-tv/ivtv-0.8
	|| ( >=media-video/vdr-1.6.0[iptv]
		>=media-video/vdr-1.6.0[pluginparam]
		>=media-video/vdr-1.7.13 )"
RDEPEND="${DEPEND}"

src_prepare() {
	vdr-plugin_src_prepare

	fix_vdr_libsi_include scanfilter.h
	fix_vdr_libsi_include scanfilter.c
	fix_vdr_libsi_include caDescriptor.h
}
