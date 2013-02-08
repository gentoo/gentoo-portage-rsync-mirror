# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/ipw2200-firmware/ipw2200-firmware-3.1.ebuild,v 1.6 2013/02/08 17:50:04 ssuominen Exp $

MY_P=${P/firmware/fw}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Firmware for the Intel PRO/Wireless 2200BG/2915ABG miniPCI and 2225BG PCI adapters"

HOMEPAGE="http://ipw2200.sourceforge.net/"
SRC_URI="http://www.bughost.org/firmware/${MY_P}.tgz"

LICENSE="ipw2200-fw"
SLOT="0"
KEYWORDS="amd64 x86"

IUSE=""

src_install() {
	insinto /lib/firmware
	doins *.fw

	doins LICENSE.ipw2200-fw
}
