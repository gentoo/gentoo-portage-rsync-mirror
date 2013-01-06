# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-atscepg/vdr-atscepg-0.1.1.ebuild,v 1.4 2009/10/30 20:28:55 hd_brummy Exp $

EAPI="2"

inherit vdr-plugin eutils

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
	vdr-plugin_src_prepare

	epatch "${FILESDIR}/${P}-gcc-4.4.diff"

	fix_vdr_libsi_include tables.cpp
}
