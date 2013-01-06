# Copyright 2004-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-screenshot/vdr-screenshot-0.0.11.ebuild,v 1.4 2008/04/28 08:41:22 zzam Exp $

inherit vdr-plugin

DESCRIPTION="Video Disk Recorder Screenshot PlugIn"
HOMEPAGE="http://www.joachim-wilke.de/?alias=vdr-screenshot"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.3.21"
RDEPEND="${DEPEND}"
