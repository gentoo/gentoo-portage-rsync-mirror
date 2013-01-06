# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-sky/vdr-sky-0.3.5.ebuild,v 1.3 2007/07/10 23:09:00 mr_bones_ Exp $

IUSE=""

inherit vdr-plugin

VDR_V=1.3.47

DESCRIPTION="VDR plugin: use kfir mpeg encoder card as input"
HOMEPAGE="http://www.cadsoft.de/vdr/"
SRC_URI="ftp://ftp.cadsoft.de/vdr/Developer/vdr-${VDR_V}.tar.bz2"

KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.3.36"

S=${WORKDIR}/vdr-${VDR_V}/PLUGINS/src/${VDRPLUGIN}
