# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-loadepg/vdr-loadepg-0.1.9.ebuild,v 1.3 2008/07/26 13:23:53 zzam Exp $

inherit vdr-plugin eutils

DESCRIPTION="VDR : Loadepg Plugin; Canal+ group (Mediahighway)"
HOMEPAGE="http://kikko77.altervista.org/"
SRC_URI="http://kikko77.altervista.org/sections/Download/[11]_loadepg/${P}.tgz"

KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=media-video/vdr-1.3.18"

src_install() {
	vdr-plugin_src_install

	insinto /etc/vdr/plugins/loadepg
	doins "${S}"/loadepg.{conf,equiv}
	fowners -R vdr:vdr /etc/vdr/plugins/loadepg
}
