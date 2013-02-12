# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-firmware/bluez-firmware/bluez-firmware-1.2.ebuild,v 1.3 2013/02/12 17:38:34 ssuominen Exp $

EAPI=5

DESCRIPTION="Firmware for Broadcom BCM203x and STLC2300 Bluetooth chips."
HOMEPAGE="http://bluez.sourceforge.net/"
SRC_URI="http://bluez.sourceforge.net/download/${P}.tar.gz"

RESTRICT="bindist mirror"

LICENSE="bluez-firmware"
SLOT="0"
KEYWORDS="amd64 hppa ppc x86"
IUSE=""

DOCS="AUTHORS ChangeLog README"

src_configure() {
	econf --libdir=/lib
}
