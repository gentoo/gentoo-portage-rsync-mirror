# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/zd1201-firmware/zd1201-firmware-0.14.ebuild,v 1.10 2013/02/08 17:56:38 ssuominen Exp $

MY_P=zd1201-${PV}-fw
S=${WORKDIR}/${MY_P}

DESCRIPTION="Firmware for ZyDAS 1201 based USB 802.11b Network WiFi devices"

HOMEPAGE="http://linux-lc100020.sourceforge.net/"
SRC_URI="mirror://sourceforge/linux-lc100020/${MY_P}.tar.gz"

LICENSE="|| ( MPL-1.1 GPL-2 )" # GPL-2 only
SLOT="0"
KEYWORDS="amd64 ppc64 x86"

IUSE=""

src_compile() { :; }

src_install() {
	insinto /lib/firmware
	doins zd1201.fw zd1201-ap.fw
	dodoc README
}
