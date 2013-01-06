# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/roxget/roxget-0.0.5c.ebuild,v 1.8 2007/11/16 14:57:48 drac Exp $

ROX_LIB_VER=1.9.16
inherit rox

DESCRIPTION="ROXget - Download Handler for the ROX Desktop"

MY_PN="ROXget"

MY_PV="005c"

HOMEPAGE="http://nipul.digitillogic.net/"

SRC_URI="http://nipul.digitillogic.net/${MY_PN}-${MY_PV}.tgz"

LICENSE="MIT"

SLOT="0"

KEYWORDS="amd64 ~ppc x86"

IUSE=""

DEPEND="dev-python/urlgrabber"

APPNAME=${MY_PN}

S=${WORKDIR}/${MY_PN}-${MY_PV}

src_unpack() {
	unpack ${A}
	cd ${MY_PN}-${MY_PV}
	mkdir ${APPNAME}
	mv * ${APPNAME}/
}
