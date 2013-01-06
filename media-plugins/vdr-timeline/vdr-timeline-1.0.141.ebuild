# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-timeline/vdr-timeline-1.0.141.ebuild,v 1.6 2007/07/10 23:09:00 mr_bones_ Exp $

inherit vdr-plugin

DESCRIPTION="VDR plugin: Timeline"
HOMEPAGE="http://www.js-home.org/vdr/timeline/"
SRC_URI="http://www.js-home.org:80/vdr/timeline/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

PATCHES="${FILESDIR}/${P}-german.diff
	${FILESDIR}/${PN}-fix-crash-no-timer.diff
	${FILESDIR}/${P}_vdr-1.5.x.diff"

DEPEND=">=media-video/vdr-1.4.1"
