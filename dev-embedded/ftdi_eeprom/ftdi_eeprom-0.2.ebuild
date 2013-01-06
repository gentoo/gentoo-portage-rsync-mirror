# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/ftdi_eeprom/ftdi_eeprom-0.2.ebuild,v 1.5 2012/06/17 23:46:33 vapier Exp $

inherit eutils

DESCRIPTION="Utility to program external EEPROM for FTDI USB chips"
HOMEPAGE="http://www.intra2net.com/opensource/ftdi/"
SRC_URI="http://www.intra2net.com/opensource/ftdi/TGZ/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="dev-embedded/libftdi
	dev-libs/confuse"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-0.2-chip-type.patch #390805
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ftdi_eeprom/example.conf
}
