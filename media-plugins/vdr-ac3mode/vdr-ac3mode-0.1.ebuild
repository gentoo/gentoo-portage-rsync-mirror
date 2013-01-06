# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-ac3mode/vdr-ac3mode-0.1.ebuild,v 1.5 2011/01/28 17:19:40 hd_brummy Exp $

EAPI="3"

inherit vdr-plugin

DESCRIPTION="VDR plugin: Show the number of audio-channels in AC3-Audio-Stream"
HOMEPAGE="http://www.vdr-portal.de/board/thread.php?threadid=32135"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.3.36"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${VDRPLUGIN}"
