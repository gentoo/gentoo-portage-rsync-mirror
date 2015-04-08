# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/ftdi_eeprom/ftdi_eeprom-0.3-r1.ebuild,v 1.6 2012/08/21 10:11:52 johu Exp $

EAPI=4
inherit eutils

DESCRIPTION="Utility to program external EEPROM for FTDI USB chips"
HOMEPAGE="http://www.intra2net.com/en/developer/libftdi/"
SRC_URI="http://www.intra2net.com/en/developer/libftdi/download/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-embedded/libftdi
	dev-libs/confuse"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-newer-chips.patch #376117
	epatch "${FILESDIR}"/${PN}-0.3-chip-type.patch #390805
}

src_install() {
	default
	dodoc src/example.conf
}
