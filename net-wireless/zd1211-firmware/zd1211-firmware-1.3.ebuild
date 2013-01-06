# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/zd1211-firmware/zd1211-firmware-1.3.ebuild,v 1.5 2012/12/11 04:13:24 axs Exp $

DESCRIPTION="Firmware for ZyDAS ZD1211 USB-WLAN devices supported by the zd1211rw driver"

MY_P=${PN}${PV}
HOMEPAGE="http://zd1211.ath.cx/wiki/DriverRewrite"
SRC_URI="mirror://sourceforge/zd1211/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"

IUSE=""
DEPEND="|| ( virtual/udev >=sys-apps/hotplug-20040923 )"

S="${WORKDIR}/${PN}"

src_install() {
	insinto /lib/firmware/zd1211
	doins zd1211_ub zd1211_ur zd1211_uphr
	doins zd1211b_ub zd1211b_ur zd1211b_uphr

	dodoc README
}
