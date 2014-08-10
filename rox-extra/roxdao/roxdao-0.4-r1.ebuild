# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/roxdao/roxdao-0.4-r1.ebuild,v 1.6 2014/08/10 20:33:58 slyfox Exp $

ROX_LIB_VER=2.0.3
inherit rox

MY_PN="RoxDAO"
DESCRIPTION="RoxDAO: A graphical frontend to cdrdao for the ROX Desktop"
HOMEPAGE="http://kymatica.com/index.php/Software"
SRC_URI="http://kymatica.com/uploads/Software/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND="app-cdr/cdrdao
	rox-extra/mp3ogg2wav"

APPNAME=${MY_PN}
APPCATEGORY="AudioVideo;DiscBurning"
S=${WORKDIR}
