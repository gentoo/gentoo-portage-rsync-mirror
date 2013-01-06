# Copyright 2003-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-pilotskin/vdr-pilotskin-0.0.2-r1.ebuild,v 1.4 2009/03/12 19:02:15 zzam Exp $

IUSE=""

inherit vdr-plugin eutils

DESCRIPTION="VDR plugin: fork of vdr-pilot - navigate through channels with skinnable design"
HOMEPAGE="http://vdrwiki.free.fr/vdr/pilotskin/"
SRC_URI="http://vdrwiki.free.fr/vdr/pilotskin/files/${P}.tgz"
KEYWORDS="~amd64 x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.3.36"

PATCHES=("${FILESDIR}/${P}-vdr-1.5.diff")
