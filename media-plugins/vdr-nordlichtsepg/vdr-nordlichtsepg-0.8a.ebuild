# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-nordlichtsepg/vdr-nordlichtsepg-0.8a.ebuild,v 1.4 2007/07/09 23:06:22 mr_bones_ Exp $

inherit vdr-plugin

IUSE=""
SLOT="0"

DESCRIPTION="vdr Plugin: Better EPG view than default vdr"
HOMEPAGE="http://martins-kabuff.de/nordlichtsepg.html"
SRC_URI="http://martins-kabuff.de/download/${P}.tgz"
LICENSE="GPL-2"

KEYWORDS="~amd64 x86"

DEPEND=">=media-video/vdr-1.3.31"

PATCHES="${FILESDIR}/${P}_vdr-1.5.3.diff"
