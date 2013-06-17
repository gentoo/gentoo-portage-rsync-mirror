# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-pcd/vdr-pcd-0.9.ebuild,v 1.8 2013/06/17 19:20:32 scarabeus Exp $

EAPI=3

inherit vdr-plugin flag-o-matic eutils

DESCRIPTION="VDR Plugin: adds the functionality to view PhotoCDs"
HOMEPAGE="http://www.heiligenmann.de/vdr/vdr/plugins/pcd.html"
SRC_URI="http://www.heiligenmann.de/vdr/download/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.4.4
		>=virtual/ffmpeg-0.10"
RDEPEND="${DEPEND}"

src_prepare() {
	vdr-plugin_src_prepare

	epatch "${FILESDIR}/${P}-ffmpeg-1.patch"

	# UINT64_C is needed by ffmpeg headers
	append-cppflags -D__STDC_CONSTANT_MACROS
}
