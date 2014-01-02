# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-remoteosd/vdr-remoteosd-1.0.0.ebuild,v 1.2 2014/01/02 13:44:01 hd_brummy Exp $

EAPI=5

inherit vdr-plugin-2

DESCRIPTION="VDR: remoteosd PlugIn"
HOMEPAGE="http://vdr.schmirler.de/"
SRC_URI="http://vdr.schmirler.de/remoteosd/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=media-video/vdr-2.0.0"
RDEPEND="${DEPEND}"
