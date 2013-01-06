# Copyright 2004-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-taste/vdr-taste-0.0.2d.ebuild,v 1.4 2008/04/13 14:04:56 zzam Exp $

IUSE=""
inherit vdr-plugin

DESCRIPTION="Video Disk Recorder Taste PlugIn"
HOMEPAGE="http://www.magoa.net/linux/index.php?view=taste"
SRC_URI="http://www.magoa.net/linux/files/${P}.tgz
		mirror://vdrfiles/${PN}/${VDRPLUGIN}-${PV}.patch"
KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.3.7"

PATCHES=("${DISTDIR}/${VDRPLUGIN}-${PV}.patch"
	"${FILESDIR}/${P}-uint64.diff"
	"${FILESDIR}/${P}-vdr-1.5.diff")
