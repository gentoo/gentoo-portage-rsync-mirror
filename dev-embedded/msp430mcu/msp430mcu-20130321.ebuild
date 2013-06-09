# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/msp430mcu/msp430mcu-20130321.ebuild,v 1.1 2013/06/09 10:48:04 radhermit Exp $

EAPI="4"

inherit eutils

DESCRIPTION="MCU-specific data for MSP430 microcontrollers"
HOMEPAGE="http://mspgcc.sourceforge.net"
SRC_URI="mirror://sourceforge/mspgcc/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_install() {
	MSP430MCU_ROOT="${S}" ./scripts/install.sh "${D}/usr"

	# remove unnecessary script
	rm "${D}"/usr/bin/${PN}-config || die
}
