# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-osdteletext/vdr-osdteletext-0.9.1.ebuild,v 1.2 2012/02/07 01:11:59 hd_brummy Exp ${VDRPLUGIN}/vdr-${VDRPLUGIN}-0.3.1.ebuild,v 1.1 2003/05/13 09:39:19 fow0ryl Exp $

EAPI="3"

inherit vdr-plugin

VERSION="685" # every bump, new version

DESCRIPTION="VDR Plugin: Osd-Teletext displays the teletext on the OSD"
HOMEPAGE="http://projects.vdr-developer.org/projects/show/plg-osdteletext"
SRC_URI="mirror://vdr-developerorg/${VERSION}/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=media-video/vdr-1.5.7"
RDEPEND="${DEPEND}"

src_install() {
	vdr-plugin_src_install

	# create the teletext directory
	diropts -m755 -ovdr -gvdr
	keepdir /var/cache/${VDRPLUGIN}
}
