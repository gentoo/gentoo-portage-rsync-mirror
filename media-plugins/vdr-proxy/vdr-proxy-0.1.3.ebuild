# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-proxy/vdr-proxy-0.1.3.ebuild,v 1.1 2007/08/14 18:45:41 zzam Exp $

inherit vdr-plugin

IUSE=""
SLOT="0"

DESCRIPTION="VDR Plugin Proxy - enable grouping of menu entries, online load/unload"
HOMEPAGE="http://urichter.cjb.net/vdr/?h=proxy"
SRC_URI="http://www.mathematik.uni-kassel.de/~urichter/vdr/files/${P}.tgz"
LICENSE="GPL-2"

KEYWORDS="~x86"

DEPEND=">=media-video/vdr-1.3.23"
