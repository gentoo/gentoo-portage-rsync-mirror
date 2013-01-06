# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/freesmee/freesmee-0.81.ebuild,v 1.2 2013/01/03 09:21:57 ago Exp $

EAPI=5

inherit qt4-r2

DESCRIPTION="Tool for sending SMS and sending/receiving Freesmee-Message-Service"
HOMEPAGE="http://www.freesmee.com"
SRC_URI="http://download.opensuse.org/repositories/home:/${PN}/xUbuntu_12.10/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug"

DEPEND="dev-util/ticpp
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-webkit:4"
RDEPEND="${DEPEND}"

src_install() {
	newbin Freesmee ${PN}
	doicon ${PN}.png
	domenu "${FILESDIR}"/${PN}.desktop
}
