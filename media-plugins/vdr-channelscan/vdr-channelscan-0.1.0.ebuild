# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-channelscan/vdr-channelscan-0.1.0.ebuild,v 1.7 2011/01/28 18:07:07 hd_brummy Exp $

EAPI="3"

inherit vdr-plugin

DESCRIPTION="VDR plugin: scan for channels on DVB-S"
HOMEPAGE="http://kikko77.altervista.org/"
SRC_URI="http://kikko77.altervista.org/sections/Download/[10]_channelscan/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.3.18"
RDEPEND="${DEPEND}"

# access transponder-data under /usr/share/vdr/channelscan-transponders
PATCHES=("${FILESDIR}/${P}-shared-data.diff"
		"${FILESDIR}/${P}-show-only-basename.diff"
		"${FILESDIR}/${P}-gcc4.diff"
		"${FILESDIR}/${P}-vdr-1.5.10.diff"
		"${FILESDIR}/${P}_gcc-4.3.x.diff")

src_prepare() {
	vdr-plugin_src_prepare
	fix_vdr_libsi_include filter.c

	has_version ">=media-video/vdr-1.7.0" && \
	epatch "${FILESDIR}/${P}-vdr-1.7.x.diff"
}

src_install() {
	vdr-plugin_src_install

	insinto /usr/share/vdr/channelscan-transponders
	doins "${S}"/transponders/*.ini
}
