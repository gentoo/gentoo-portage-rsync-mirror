# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-zappilot/vdr-zappilot-0.0.4.ebuild,v 1.3 2012/04/30 20:35:05 hd_brummy Exp $

EAPI="4"

inherit vdr-plugin-2

VERSION="358" # every bump new version

DESCRIPTION="VDR Plugin: browse fast the EPG information without being forced to switch to a channel"
HOMEPAGE="http://projects.vdr-developer.org/projects/show/plg-zappilot"
SRC_URI="mirror://vdr-developerorg/${VERSION}/${P}.tgz"

KEYWORDS="amd64 x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=media-video/vdr-1.6.0"
RDEPEND="${DEPEND}"

src_prepare() {
	vdr-plugin-2_src_prepare

	sed -i Makefile -e "s:DEFINES += -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE::"
}
