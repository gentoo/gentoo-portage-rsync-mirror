# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-undelete/vdr-undelete-0.0.6-r1.ebuild,v 1.8 2009/08/09 19:07:29 ssuominen Exp $

inherit vdr-plugin

IUSE=""
SLOT="0"

DESCRIPTION="VDR Plugin: Undelete of Recordings"
HOMEPAGE="http://www.fast-info.de/vdr/undelete/index.htm"
SRC_URI="http://www.fast-info.de/vdr/undelete/${P}.tgz"
LICENSE="GPL-2"

KEYWORDS="x86 ~amd64"

DEPEND=">=media-video/vdr-1.2.6"
RDEPEND="${DEPEND}"

PATCHES=("${FILESDIR}/${P#vdr-}-info.diff"
	"${FILESDIR}/${P#vdr-}-vdr-1.5.7.diff"
	"${FILESDIR}/${P}_vdr-1.7.3.diff"
	"${FILESDIR}/${P}-glibc-2.10.patch" )
