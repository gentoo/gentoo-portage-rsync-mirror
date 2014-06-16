# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-firmware/iwl7260-ucode/iwl7260-ucode-22.15.8.0.ebuild,v 1.4 2014/06/16 14:07:54 gienah Exp $

EAPI=5
inherit linux-info

MY_PN="iwlwifi-7260-ucode"

DESCRIPTION="Firmware for Intel (R) Dual Band Wireless-AC 7260"
HOMEPAGE="http://wireless.kernel.org/en/users/Drivers/iwlwifi"
SRC_URI="http://wireless.kernel.org/en/users/Drivers/iwlwifi?action=AttachFile&do=get&target=${MY_PN}-${PV}.tgz -> ${P}.tgz"

LICENSE="ipw3945"
SLOT="1"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="!sys-kernel/linux-firmware[-savedconfig]"

S="${WORKDIR}/${MY_PN}-${PV}"

CONFIG_CHECK="IWLMVM"
ERROR_IWLMVM="CONFIG_IWLMVM is required to be enabled in /usr/src/linux/.config for the kernel to be able to load the 7260 firmware"

pkg_pretend() {
	if kernel_is lt 3 13 0; then
		ewarn "Your kernel version is ${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}."
		ewarn "This microcode image requires a kernel >= 3.13.0."
		ewarn "For kernel versions < 3.13.0, you may install older SLOTS"
	fi
}

src_install() {
	insinto /lib/firmware
	doins "${S}/iwlwifi-7260-8.ucode"
	dodoc README*
}
