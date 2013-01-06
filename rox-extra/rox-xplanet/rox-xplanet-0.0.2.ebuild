# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/rox-xplanet/rox-xplanet-0.0.2.ebuild,v 1.4 2007/11/16 15:16:51 drac Exp $

ROX_LIB_VER=2.0.3
inherit rox

MY_PN="XPlanet"
DESCRIPTION="ROX wrapper for xplanet by Stephen Watson"
HOMEPAGE="http://www.kerofin.demon.co.uk/rox/xplanet.html"
SRC_URI="http://www.kerofin.demon.co.uk/rox/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=x11-misc/xplanet-1"

APPNAME="${MY_PN}"
S="${WORKDIR}"
