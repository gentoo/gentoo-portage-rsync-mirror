# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-yaepg/vdr-yaepg-0.0.10.ebuild,v 1.2 2014/01/08 01:33:09 hd_brummy Exp $

EAPI=5

inherit vdr-plugin-2

DESCRIPTION="VDR Plugin: another epg osd"
HOMEPAGE="http://vdr.websitec.de/download/vdr-yaepg"
SRC_URI="http://vdr.websitec.de/download/vdr-yaepg/vdr-yaepg-0.0.10.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=media-video/vdr-1.5.7[yaepg]"
