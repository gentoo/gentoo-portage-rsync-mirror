# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/clock/clock-2.1.7.ebuild,v 1.8 2009/05/31 13:34:07 nixnut Exp $

ROX_CLIB_VER=2.1.8
inherit rox eutils

MY_PN="Clock"

DESCRIPTION="Clock - a clock for the ROX Desktop"
HOMEPAGE="http://www.kerofin.demon.co.uk/rox/clock.html"
SRC_URI="http://www.kerofin.demon.co.uk/rox/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

APPNAME=Clock
S=${WORKDIR}
