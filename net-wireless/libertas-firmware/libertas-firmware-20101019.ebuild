# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/libertas-firmware/libertas-firmware-20101019.ebuild,v 1.3 2013/02/10 13:39:48 ssuominen Exp $

EAPI=5

MY_PN=${PN/-firmware}

DESCRIPTION="Firmware for the Marvell Libertas wlan chipsets (OLPC, GuruPlug)"
HOMEPAGE="http://git.kernel.org/?p=linux/kernel/git/dwmw2/linux-firmware.git;a=tree;f=libertas;hb=HEAD"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="libertas-fw"
SLOT="0"
KEYWORDS="~arm"
IUSE=""

S=${WORKDIR}/${MY_PN}

src_install() {
	insinto /lib/firmware
	doins *.bin
}
