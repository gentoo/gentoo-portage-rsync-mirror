# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-osdserver/vdr-osdserver-0.1.1.ebuild,v 1.1 2007/12/02 16:02:36 hd_brummy Exp $

inherit vdr-plugin

DESCRIPTION="VDR plugin: provides VDR OSD access to external programs and scripts through a TCP/IP socket connection, just like an X server does."
HOMEPAGE="http://www.udo-richter.de/vdr/osdserver.en.html"
SRC_URI=" http://www.udo-richter.de/vdr/files/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.4.6"

RDEPEND=""

PATCHES="${FILESDIR}/${P}-gentoo.diff"

src_install() {
	vdr-plugin_src_install

	insinto /etc/vdr/plugins/osdserver
	doins   "${FILESDIR}"/osdserverhosts.conf

	dodoc examples/helloworld.{sh,pl}
}

pkg_postinst() {
	vdr-plugin_pkg_postinst

	echo
	elog "Check configuration files:"
	elog "/etc/vdr/plugins/osdserver/osdserverhosts.conf"
	elog "/etc/conf.d/vdr.osdserver"
	elog "Examples are in '/usr/share/doc/vdr/${P}/'"
	echo
}
