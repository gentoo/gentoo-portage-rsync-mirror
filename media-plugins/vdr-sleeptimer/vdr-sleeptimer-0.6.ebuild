# Copyright 2005-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-sleeptimer/vdr-sleeptimer-0.6.ebuild,v 1.2 2006/04/17 17:04:28 zzam Exp $

IUSE=""

inherit vdr-plugin

DESCRIPTION="Video Disk Recorder Sleeptimer PlugIn"
HOMEPAGE="http://linvdr.org/download/vdr-sleeptimer"
SRC_URI="http://linvdr.org/download/vdr-sleeptimer/${VDRPLUGIN}-${PV}.tar.gz"

KEYWORDS="x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.2.6"

PATCHES="${FILESDIR}/${P}-includes.diff"
