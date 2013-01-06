# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/resolution/resolution-0.2-r1.ebuild,v 1.4 2007/11/16 15:21:07 drac Exp $

ROX_LIB_VER=1.9.3
inherit rox

DESCRIPTION="This rox program allows you to change the screen resolution at any time. It is non-permanent"
HOMEPAGE="http://rox.sourceforge.net/"
SRC_URI="http://rox.sourceforge.net/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=""
RDEPEND="x11-apps/xrandr"

APPNAME=Resolution
APPCATEGORY="Settings;HardwareSettings"
