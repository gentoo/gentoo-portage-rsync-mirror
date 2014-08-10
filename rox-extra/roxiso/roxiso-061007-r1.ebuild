# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/roxiso/roxiso-061007-r1.ebuild,v 1.5 2014/08/10 20:34:07 slyfox Exp $

ROX_LIB_VER=1.9.13
inherit rox

MY_PN="RoxISO"

DESCRIPTION="RoxISO. A graphical frontend to mkisofs and cdrecord"
HOMEPAGE="http://kymatica.com/index.php/Software"
SRC_URI="http://kymatica.com/uploads/Software/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND="virtual/cdrtools"

APPNAME=RoxISO
APPCATEGORY="Utility;DiscBurning"
S="${WORKDIR}"
