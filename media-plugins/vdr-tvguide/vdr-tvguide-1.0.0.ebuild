# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-tvguide/vdr-tvguide-1.0.0.ebuild,v 1.1 2014/01/28 20:18:53 idl0r Exp $

EAPI=5

MY_P="${P/vdr-}"

VERSION="1402"

inherit vdr-plugin-2

DESCRIPTION="highly customizable 2D EPG viewer plugin for the Video Disc
Recorder"
HOMEPAGE="http://projects.vdr-developer.org/projects/plg-tvguide"
SRC_URI="mirror://vdr-developerorg/${VERSION}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="|| ( media-gfx/imagemagick media-gfx/graphicsmagick )
	media-plugins/vdr-epgsearch"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}/${MY_P}"

pkg_postinst() {
	vdr-plugin-2_pkg_postinst

	einfo "See http://projects.vdr-developer.org/projects/skin-nopacity/wiki"
	einfo "for more information about how to use channel logos"
}
