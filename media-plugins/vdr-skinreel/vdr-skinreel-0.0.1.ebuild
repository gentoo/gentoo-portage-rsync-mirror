# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-skinreel/vdr-skinreel-0.0.1.ebuild,v 1.4 2007/07/10 23:09:00 mr_bones_ Exp $

inherit vdr-plugin

DESCRIPTION="Video Disk Recorder - Skin Plugin"
HOMEPAGE="http://www.vdr-wiki.de/wiki/index.php/Skinreel-plugin"
SRC_URI="mirror://vdrfiles/${PN}/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.3.22"

pkg_postinst() {
	vdr-plugin_pkg_postinst

	ewarn "You can not use this skin with"
	ewarn "an unmodified dvb-card (fullfeatured) with only 2MB of RAM."
}
