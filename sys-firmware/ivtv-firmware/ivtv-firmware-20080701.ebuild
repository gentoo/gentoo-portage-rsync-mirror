# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-firmware/ivtv-firmware/ivtv-firmware-20080701.ebuild,v 1.3 2013/02/11 04:55:40 cardoe Exp $

DESCRIPTION="firmware for Hauppauge PVR-x50 and Conexant 2341x based cards"
HOMEPAGE="http://www.ivtvdriver.org/index.php/Firmware"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="Hauppauge-Firmware"
KEYWORDS="amd64 ppc x86"
SLOT=0
IUSE=""
RDEPEND=""

S="${WORKDIR}"

src_install() {
	dodir /lib/firmware
	insinto /lib/firmware
	doins *.fw
	doins *.mpg
}
