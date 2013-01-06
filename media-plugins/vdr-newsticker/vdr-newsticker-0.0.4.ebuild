# Copyright 2003-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-newsticker/vdr-newsticker-0.0.4.ebuild,v 1.5 2007/08/13 12:36:42 angelos Exp $

IUSE=""

inherit vdr-plugin eutils

DESCRIPTION="VDR plugin: Show rdf Newsticker on TV"
HOMEPAGE="http://www.wontorra.net"
SRC_URI="http://www.wontorra.net/filemgmt_data/files/${P}.tar.gz"
KEYWORDS="~amd64 x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.2.6
	net-misc/wget"

PATCHES="${FILESDIR}/${P}-gcc4.diff"

src_install() {
	vdr-plugin_src_install

	keepdir /var/vdr/newsticker
	chown vdr:vdr ${D}/var/vdr/newsticker
}
