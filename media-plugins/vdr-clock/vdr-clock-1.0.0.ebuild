# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-clock/vdr-clock-1.0.0.ebuild,v 1.4 2011/01/28 21:21:43 mr_bones_ Exp $

EAPI="3"

inherit vdr-plugin

DESCRIPTION="Video Disk Recorder Clock PlugIn"
HOMEPAGE="http://vdr.aistleitner.info"
SRC_URI="http://vdr.aistleitner.info/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=media-video/vdr-1.2.0"
RDEPEND="${DEPEND}"
