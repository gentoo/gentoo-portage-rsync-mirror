# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/rox-launch/rox-launch-0.3.2.ebuild,v 1.4 2008/08/30 20:02:46 maekke Exp $

ROX_LIB_VER=2.0.2
inherit rox-0install

MY_PN="Launch"
DESCRIPTION="Launch provides facilities for launching URLs and configuring the
applications used to launch them."
HOMEPAGE="http://www.kerofin.demon.co.uk/rox/launch.html"
SRC_URI="http://www.kerofin.demon.co.uk/rox/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

APPNAME=${MY_PN}
S=${WORKDIR}
