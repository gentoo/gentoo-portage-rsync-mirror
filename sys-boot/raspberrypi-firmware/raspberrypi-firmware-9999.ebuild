# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/raspberrypi-firmware/raspberrypi-firmware-9999.ebuild,v 1.1 2013/07/15 06:58:46 xmw Exp $

EAPI=5

inherit git-2 readme.gentoo

DESCRIPTION="Raspberry PI boot loader and firmware"
HOMEPAGE="https://github.com/raspberrypi/firmware"
EGIT_REPO_URI="https://github.com/raspberrypi/firmware.git"
EGIT_PROJECT="raspberrypi-firmware.git"

LICENSE="GPL-2 raspberrypi-videocore-bin"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="!sys-boot/raspberrypi-loader"

RESTRICT="binchecks strip"

src_install() {
	insinto /boot
	doins bootcode.bin boot/fixup*.dat boot/start*.elf
	newins "${FILESDIR}"/${P}-config.txt config.txt
	newins "${FILESDIR}"/${P}-cmdline.txt cmdline.txt
	newenvd "${FILESDIR}"/${P}-envd 90${PN}
	readme.gentoo_create_doc
}

DOC_CONTENTS="Please configure your ram setup by editing /boot/config.txt"
