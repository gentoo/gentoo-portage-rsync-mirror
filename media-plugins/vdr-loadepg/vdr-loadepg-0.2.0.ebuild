# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-loadepg/vdr-loadepg-0.2.0.ebuild,v 1.1 2008/07/26 13:23:53 zzam Exp $

inherit vdr-plugin eutils

DESCRIPTION="VDR : Loadepg Plugin; Canal+ group (Mediahighway)"
HOMEPAGE="http://lukkinosat.altervista.org/"
SRC_URI="http://lukkinosat.altervista.org/${P}.tgz"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=media-video/vdr-1.4.0"

src_install() {
	vdr-plugin_src_install

	insinto /etc/vdr/plugins/loadepg
	doins "${S}"/conf/*
	fowners -R vdr:vdr /etc/vdr/plugins/loadepg
}
