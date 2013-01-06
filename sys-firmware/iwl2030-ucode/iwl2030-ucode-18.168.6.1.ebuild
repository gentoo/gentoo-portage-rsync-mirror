# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-firmware/iwl2030-ucode/iwl2030-ucode-18.168.6.1.ebuild,v 1.2 2012/10/03 19:31:41 vapier Exp $

MY_PN=${PN/iwl/iwlwifi-}

DESCRIPTION="Intel (R) Wireless WiFi Advanced N 2030 ucode"
HOMEPAGE="http://intellinuxwireless.org/?p=iwlwifi"
SRC_URI="http://intellinuxwireless.org/iwlwifi/downloads/${MY_PN}-${PV}.tgz"

LICENSE="ipw3945"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${MY_PN}-${PV}"

src_compile() { :; }

src_install() {
	insinto /lib/firmware
	doins iwlwifi-2030-6.ucode

	dodoc README*
}
