# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/virtualbox-additions/virtualbox-additions-4.1.24.ebuild,v 1.1 2012/12/22 12:25:44 polynomial-c Exp $

EAPI=2

inherit eutils

MY_PN=VBoxGuestAdditions
MY_P=${MY_PN}_${PV}

DESCRIPTION="CD image containing guest additions for VirtualBox"
HOMEPAGE="http://www.virtualbox.org/"
SRC_URI="http://download.virtualbox.org/virtualbox/${PV}/${MY_P}.iso"

LICENSE="PUEL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND="!app-emulation/virtualbox-bin
	!=app-emulation/virtualbox-9999"

src_unpack() {
	return 0
}

src_install() {
	insinto /usr/share/${PN/-additions}
	newins "${DISTDIR}"/${MY_P}.iso ${MY_PN}.iso
}
