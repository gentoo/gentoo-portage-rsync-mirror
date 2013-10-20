# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-skinnopacity/vdr-skinnopacity-0.1.4.ebuild,v 1.2 2013/10/20 20:55:08 idl0r Exp $

EAPI=5

MY_P="${P/vdr-}"
VERSION="1445"

inherit vdr-plugin-2

DESCRIPTION="highly customizable native true color skin for the Video Disc
Recorder"
HOMEPAGE="http://projects.vdr-developer.org/projects/skin-nopacity/"
SRC_URI="mirror://vdr-developerorg/${VERSION}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-misc/curl
	dev-libs/libxml2
	|| ( media-gfx/imagemagick media-gfx/graphicsmagick )
	media-plugins/vdr-epgsearch"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}/${MY_P}"

pkg_postinst() {
	vdr-plugin-2_pkg_postinst

	einfo "See http://projects.vdr-developer.org/projects/skin-nopacity/wiki"
	einfo "for more information about how to use channel logos"
}
