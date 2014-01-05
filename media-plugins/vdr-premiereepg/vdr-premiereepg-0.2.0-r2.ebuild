# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-premiereepg/vdr-premiereepg-0.2.0-r2.ebuild,v 1.1 2014/01/05 19:44:32 hd_brummy Exp $

EAPI=5

inherit vdr-plugin-2

DESCRIPTION="VDR Plugin: Support the extended EPG which is sent by german paytv Sky on their portal channels"
HOMEPAGE="http://www.muempf.de/index.html"
SRC_URI="http://www.muempf.de/down/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.4.1"
RDEPEND="${DEPEND}"

src_prepare() {
	vdr-plugin-2_src_prepare

	if has_version ">=media-video/vdr-2.1.3"; then
		sed -i premiereepg.c -e "s:MAXDVBDEVICES:MAXDEVICES:"
	fi

	fix_vdr_libsi_include premiereepg.c
}
