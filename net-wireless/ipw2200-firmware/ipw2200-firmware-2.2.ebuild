# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/ipw2200-firmware/ipw2200-firmware-2.2.ebuild,v 1.7 2012/12/11 17:32:34 axs Exp $

MY_P=${P/firmware/fw}
S=${WORKDIR}

DESCRIPTION="Firmware for the Intel PRO/Wireless 2200BG/2915ABG miniPCI and 2225BG PCI adapters"

HOMEPAGE="http://ipw2200.sourceforge.net"
SRC_URI="mirror://gentoo/${MY_P}.tgz"

LICENSE="ipw2200-fw"
SLOT="${PV}"
KEYWORDS="x86 ~amd64"

IUSE=""
DEPEND="|| ( virtual/udev >=sys-apps/hotplug-20040923 )
	!<sys-fs/udev-096"

src_install() {
	insinto /lib/firmware
	doins *.fw

	newins LICENSE ipw-${PV}-LICENSE
}
