# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/freesmee/freesmee-0.7-r3.ebuild,v 1.1 2012/08/09 17:30:42 ago Exp $

EAPI=4

inherit qt4-r2

DESCRIPTION="Tool for sending SMS and sending/receiving Freesmee-Message-Service"
HOMEPAGE="http://www.freesmee.com"
SRC_URI="http://ftp5.gwdg.de/pub/opensuse/repositories/home:/${PN}/xUbuntu_11.10/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="dev-util/ticpp
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-webkit:4"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}"/${PN}-qt-4.8.1.patch "${FILESDIR}"/${PN}-gcc47.patch )

src_install() {
	newbin Freesmee ${PN}
	doicon ${PN}.png
	make_desktop_entry ${PN} \
		Freesmee \
		${PN} \
		"Application;Network;"
}
