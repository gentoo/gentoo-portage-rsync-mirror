# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-premiereepg/vdr-premiereepg-0.2.0.ebuild,v 1.3 2011/01/17 21:42:59 hd_brummy Exp $

EAPI="2"

inherit vdr-plugin eutils

DESCRIPTION="VDR Plugin: Support the extended EPG which is sent by german paytv Sky on their portal channels"
HOMEPAGE="http://www.muempf.de/index.html"
SRC_URI="http://www.muempf.de/down/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=media-video/vdr-1.4.1"
RDEPEND="${DEPEND}"

src_prepare() {
	vdr-plugin_src_prepare

	fix_vdr_libsi_include premiereepg.c
}
