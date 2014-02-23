# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-zaphistory/vdr-zaphistory-0.9.5.ebuild,v 1.5 2014/02/23 21:12:46 hd_brummy Exp $

EAPI=5

inherit vdr-plugin-2

IUSE=""
SLOT="0"

DESCRIPTION="vdr Plugin: Shows the least recently used channels"
HOMEPAGE="http://vaasa.wi-bw.tfh-wildau.de/~pjuszack/digicam/#zaphistory"
SRC_URI="http://vaasa.wi-bw.tfh-wildau.de/~pjuszack/digicam/download/${P}.tgz"
LICENSE="GPL-2"

KEYWORDS="x86"

DEPEND=">=media-video/vdr-1.3.34"

PATCHES=("${FILESDIR}/${PN}-0.9.4-fix-crash-no-info.diff")
