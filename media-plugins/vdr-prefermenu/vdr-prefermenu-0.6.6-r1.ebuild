# Copyright 2003-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-prefermenu/vdr-prefermenu-0.6.6-r1.ebuild,v 1.5 2009/03/12 20:49:50 zzam Exp $

inherit vdr-plugin

DESCRIPTION="Video Disk Recorder Prefermenu Plugin"
HOMEPAGE="http://www.olivierjacques.com/vdr/prefermenu/"
SRC_URI="http://famillejacques.free.fr/vdr/prefermenu/vdr-${VDRPLUGIN}-${PV}.tgz
		mirror://vdrfiles/${PN}/vdr-${VDRPLUGIN}-${PV}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND=">=media-video/vdr-1.3.45"

PATCHES=("${FILESDIR}/${P}-no-static-getfont.diff")

src_install() {
	vdr-plugin_src_install

	touch prefermenu.conf
	insinto /etc/vdr/plugins
	doins prefermenu.conf
	chown vdr:vdr -R "${D}"/etc/vdr
}
