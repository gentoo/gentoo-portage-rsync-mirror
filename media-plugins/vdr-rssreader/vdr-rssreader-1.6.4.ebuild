# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-rssreader/vdr-rssreader-1.6.4.ebuild,v 1.4 2012/06/21 13:23:14 hd_brummy Exp $

EAPI="4"

inherit vdr-plugin-2

DESCRIPTION="VDR Plugin: RSS feed reader"
HOMEPAGE="http://www.saunalahti.fi/~rahrenbe/vdr/rssreader/"
SRC_URI="http://www.saunalahti.fi/~rahrenbe/vdr/rssreader/files/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=media-video/vdr-1.6.0
		>=dev-libs/expat-1.95.8
		>=net-misc/curl-7.15.1-r1"

RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${P}-gentoo-rss.diff"
	"${FILESDIR}/${P}-curl-headers.patch"
	"${FILESDIR}/${P}_gcc-4.7.diff" )

src_install() {
	vdr-plugin-2_src_install

	insinto /etc/vdr/plugins/rssreader
	doins "${S}/rssreader/rssreader.conf"
}
