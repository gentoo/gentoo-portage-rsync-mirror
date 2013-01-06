# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-reelchannelscan/vdr-reelchannelscan-0.3.3.ebuild,v 1.3 2007/11/21 09:45:11 zzam Exp $

inherit vdr-plugin

DESCRIPTION="vdr Plugin: Channel Scanner"
HOMEPAGE="http://www.reel-multimedia.com"
SRC_URI="http://www.reelbox.org/software/source/vdr-plugins/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.3.18"

pkg_setup(){
	vdr-plugin_pkg_setup

	if ! grep -q scanning_on_receiving_device /usr/include/vdr/device.h; then
		ewarn "your vdr needs to be patched to use vdr-channelscan"
		die "unpatched vdr detected"
	fi
}

src_unpack() {
	vdr-plugin_src_unpack

	fix_vdr_libsi_include filter.h
}

src_install() {
	vdr-plugin_src_install

	cd "${S}"/transponders
	insinto /usr/share/vdr/channelscan/transponders
	doins *.tpl

	insinto /etc/vdr/plugins
	dosym /usr/share/vdr/channelscan/transponders /etc/vdr/plugins/transponders
}
