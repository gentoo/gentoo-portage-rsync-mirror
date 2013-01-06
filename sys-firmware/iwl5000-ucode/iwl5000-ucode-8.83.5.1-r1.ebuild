# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-firmware/iwl5000-ucode/iwl5000-ucode-8.83.5.1-r1.ebuild,v 1.4 2012/12/25 04:06:27 jdhore Exp $

EAPI=5
inherit linux-info

MY_PN="iwlwifi-5000-ucode"
MY_PV="${PV}-1"

DESCRIPTION="Intel (R) Wireless WiFi Link 5100/5300 ucode"
HOMEPAGE="http://intellinuxwireless.org/?p=iwlwifi"
SRC_URI="http://intellinuxwireless.org/iwlwifi/downloads/${MY_PN}-${MY_PV}.tar.gz"

LICENSE="ipw3945"
SLOT="2"
KEYWORDS="amd64 x86"
IUSE=""
RDEPEND="!=${CATEGORY}/${P}"

S="${WORKDIR}/${MY_PN}-${MY_PV}"

pkg_pretend() {
	if kernel_is lt 2 6 38; then
		ewarn "Your kernel version is ${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}."
		ewarn "This microcode image requires a kernel >= 2.6.38."
		ewarn "For kernel versions < 2.6.38, you may install older SLOTS"
	fi
}

src_install() {
	insinto /lib/firmware
	doins "${S}/iwlwifi-5000-5.ucode"
	dodoc README*
}
