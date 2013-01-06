# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-pin/vdr-pin-0.1.9.ebuild,v 1.3 2010/12/02 16:14:05 hd_brummy Exp $

EAPI="2"

inherit vdr-plugin

DESCRIPTION="VDR plugin: pin PlugIn"
HOMEPAGE="http://www.jwendel.de"
SRC_URI="http://www.jwendel.de/vdr/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.6.0[pinplugin]"

src_prepare() {
	vdr-plugin_src_prepare

	epatch "${FILESDIR}/${P}.diff"
}

src_install() {
	vdr-plugin_src_install

	dobin fskcheck

	into /usr/share/vdr/pin
	dobin "${S}"/scripts/*.sh

	insinto /etc/vdr/reccmds
	newins "${FILESDIR}"/reccmds.pin.conf-0.0.16 reccmds.pin.conf
}
