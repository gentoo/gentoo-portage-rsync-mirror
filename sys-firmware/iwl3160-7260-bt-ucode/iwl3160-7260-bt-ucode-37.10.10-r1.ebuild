# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-firmware/iwl3160-7260-bt-ucode/iwl3160-7260-bt-ucode-37.10.10-r1.ebuild,v 1.1 2014/01/31 13:05:34 gienah Exp $

EAPI=5
inherit linux-info

MY_PN="iwlwifi-7260-ucode"

DESCRIPTION="Firmware for Intel (R) Dual Band Wireless-AC 7260"
HOMEPAGE="http://wireless.kernel.org/en/users/Drivers/iwlwifi"
SRC_URI="mirror://gentoo/${P}.tgz"

LICENSE="ipw3945"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="!sys-kernel/linux-firmware[-savedconfig]"

S="${WORKDIR}"

CONFIG_CHECK="IWLMVM"
ERROR_IWLMVM="CONFIG_IWLMVM is required to be enabled in /usr/src/linux/.config for the kernel to be able to load the 7260 firmware"

pkg_pretend() {
	if kernel_is lt 3 10 0; then
		ewarn "Your kernel version is ${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}."
		ewarn "This microcode image requires a kernel >= 3.10.0."
	fi
}

src_install() {
	insinto /lib/firmware/intel
	doins "${S}/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq"
	doins "${S}/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq"
	doins "${S}/ibt-hw-37.7.bseq"
}
