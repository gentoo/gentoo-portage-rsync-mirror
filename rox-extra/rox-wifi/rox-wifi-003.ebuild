# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/rox-wifi/rox-wifi-003.ebuild,v 1.4 2007/11/16 15:17:45 drac Exp $

ROX_LIB_VER=2.0.0
inherit rox

MY_PN="WiFi"
DESCRIPTION="WiFi - A wireless signal monitor applet for ROX."
HOMEPAGE="http://code.google.com/p/rox-wifi/wiki/WiFi"
SRC_URI="http://rox-wifi.googlecode.com/files/${MY_PN}-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

APPNAME=${MY_PN}
S=${WORKDIR}
WRAPPERNAME="skip"
