# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/lithium/lithium-006.ebuild,v 1.6 2014/08/10 20:32:27 slyfox Exp $

ROX_LIB_VER=2.0.0
inherit rox

MY_PN="Lithium"
DESCRIPTION="Lithium - A battery-status applet for ROX"
HOMEPAGE="http://rox-lithium.googlecode.com"
SRC_URI="http://rox-lithium.googlecode.com/files/${MY_PN}-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

APPNAME=${MY_PN}
APPCATEGORY=""
S=${WORKDIR}

src_unpack() {
	mkdir ${MY_PN}
	cd ${MY_PN}
	unpack ${A}
}
