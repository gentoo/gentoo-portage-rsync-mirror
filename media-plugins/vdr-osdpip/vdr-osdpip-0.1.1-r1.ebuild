# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-osdpip/vdr-osdpip-0.1.1-r1.ebuild,v 1.1 2012/10/20 18:02:23 hd_brummy Exp $

EAPI="4"

VERSION="880" # every bump, new version

inherit vdr-plugin-2 flag-o-matic

DESCRIPTION="VDR plugin: Show another channel in the OSD"
HOMEPAGE="http://projects.vdr-developer.org/projects/plg-osdpip"
SRC_URI="mirror://vdr-developerorg/${VERSION}/${P}.tgz"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=media-video/vdr-1.6.0_p2-r5
	>=media-libs/libmpeg2-0.5.1
	>=virtual/ffmpeg-0.6.90"
RDEPEND="${DEPEND}"

src_prepare() {
	vdr-plugin-2_src_prepare

	# UINT64_C is needed by ffmpeg headers
	append-cxxflags -D__STDC_CONSTANT_MACROS
}
