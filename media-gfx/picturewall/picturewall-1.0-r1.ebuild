# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/picturewall/picturewall-1.0-r1.ebuild,v 1.4 2012/02/18 15:23:55 pesa Exp $

EAPI=4

inherit eutils qt4-r2

MY_PN="PictureWall"

DESCRIPTION="Qt4 picture viewer and image searching tool using google.com"
HOMEPAGE="http://www.qt-apps.org/content/show.php?content=106101"
SRC_URI="http://picturewall.googlecode.com/files/${MY_PN}_${PV}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug doc"

RDEPEND=">=x11-libs/qt-core-4.5.3:4
	>=x11-libs/qt-gui-4.5.3:4
	>=x11-libs/qt-webkit-4.5.3:4"
DEPEND="app-arch/unzip
	${RDEPEND}"

S=${WORKDIR}/${MY_PN}/${MY_PN}

src_install(){
	dobin bin/${PN}
	dodoc ReadMe
	use doc && dohtml -r doc/html/*
	make_desktop_entry ${PN} ${MY_PN}
}
