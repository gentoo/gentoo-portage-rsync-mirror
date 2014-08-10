# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/rox-wifi/rox-wifi-003.ebuild,v 1.6 2014/08/10 20:33:49 slyfox Exp $

ROX_LIB_VER=2.0.0
inherit rox unpacker

MY_PN="WiFi"
DESCRIPTION="WiFi - A wireless signal monitor applet for ROX"
HOMEPAGE="http://code.google.com/p/rox-wifi/wiki/WiFi"
SRC_URI="http://rox-wifi.googlecode.com/files/${MY_PN}-${PV}.tgz
	http://dev.gentoo.org/~ssuominen/pngcrush-fixed-nm-signal-icons.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=""
DEPEND="app-arch/xz-utils"

APPNAME=${MY_PN}
S=${WORKDIR}
WRAPPERNAME="skip"

src_unpack() {
	unpacker_src_unpack
	mv -f "${WORKDIR}"/nm-signal-*.png "${WORKDIR}"/WiFi/themes/Tango/ #466190
}
