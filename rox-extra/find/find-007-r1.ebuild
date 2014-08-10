# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/find/find-007-r1.ebuild,v 1.7 2014/08/10 20:32:20 slyfox Exp $

ROX_LIB_VER=2.0.0
inherit rox

MY_PN="Find"
DESCRIPTION="Find - A file Finder utility for ROX by Ken Hayber"
HOMEPAGE="http://rox-find.googlecode.com"
SRC_URI="http://rox-find.googlecode.com/files/${MY_PN}-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

APPNAME=${MY_PN}
APPCATEGORY="Utility"
S=${WORKDIR}
