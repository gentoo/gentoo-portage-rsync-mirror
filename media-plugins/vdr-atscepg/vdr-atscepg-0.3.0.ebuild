# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-atscepg/vdr-atscepg-0.3.0.ebuild,v 1.3 2012/06/30 17:31:40 hd_brummy Exp $

EAPI="4"

inherit vdr-plugin-2

DESCRIPTION="VDR plugin: receive schedule and event information from ATSC broadcasts"
HOMEPAGE="http://www.fepg.org/atscepg.html"
SRC_URI="http://www.fepg.org/files/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.6[atsc]"
RDEPEND="${DEPEND}"

src_prepare() {
	vdr-plugin-2_src_prepare

	fix_vdr_libsi_include tables.cpp filter.cpp
}
