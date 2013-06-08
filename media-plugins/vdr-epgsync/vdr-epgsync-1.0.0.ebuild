# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-epgsync/vdr-epgsync-1.0.0.ebuild,v 1.1 2013/06/08 20:18:29 hd_brummy Exp $

EAPI="5"

inherit vdr-plugin-2

DESCRIPTION="VDR Plugin: Import the EPG of another VDR via vdr-svdrpservice"
HOMEPAGE="http://vdr.schmirler.de/"
SRC_URI="http://vdr.schmirler.de/epgsync/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-2.0.0"
RDEPEND="${DEPEND}"
