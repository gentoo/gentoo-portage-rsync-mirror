# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-reelchannelscan/vdr-reelchannelscan-0.4.3-r2.ebuild,v 1.5 2007/11/21 09:45:11 zzam Exp $

inherit vdr-plugin eutils

DESCRIPTION="vdr Plugin: Channel Scanner"
HOMEPAGE="http://www.reel-multimedia.com"
SRC_URI="mirror://gentoo/${P}.tgz
	http://dev.gentoo.org/~zzam/distfiles/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
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
	vdr-plugin_src_unpack unpack
	cd "${S}"
	epatch "${FILESDIR}/${PV}/default-source-if-no-channel-set.diff"
	epatch "${FILESDIR}/${PV}/device-numbering.diff"
	epatch "${FILESDIR}/${PV}/i18n.diff"
	epatch "${FILESDIR}/${PV}/gentoo.diff"

	fix_vdr_libsi_include filter.[ch]
	vdr-plugin_src_unpack all_but_unpack
}

src_install() {
	vdr-plugin_src_install

	cd "${S}"/transponders
	insinto /usr/share/vdr/reelchannelscan/transponders
	doins *.tpl
}
