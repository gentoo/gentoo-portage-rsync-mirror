# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/ipw2100-firmware/ipw2100-firmware-1.3.ebuild,v 1.9 2013/02/10 08:38:06 ssuominen Exp $

EAPI=5

MY_P=${P/firmware/fw}

DESCRIPTION="Firmware for the Intel PRO/Wireless 2100 3B miniPCI adapter"
HOMEPAGE="http://ipw2100.sourceforge.net/"
SRC_URI="mirror://gentoo/${MY_P}.tgz"

LICENSE="ipw2100-fw"
SLOT="${PV}"
KEYWORDS="amd64 x86"
IUSE=""

S=${WORKDIR}

src_install() {
	insinto /lib/firmware
	doins ipw2100-${PV}{,-i,-p}.fw
}
