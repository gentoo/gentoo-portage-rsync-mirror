# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/raspberrypi-firmware/raspberrypi-firmware-9999.ebuild,v 1.2 2013/07/15 11:34:34 xmw Exp $

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

pkg_preinst() {
	if [ -z "${REPLACING_VERSIONS}" ] ; then
		if [ -e /boot/cmdline.txt -o -e /boot/config.txt ] ; then
			die "Please backup and remove /boot/cmdline.txt and /boot/config.txt to and merge configs after installation."
		fi
	fi
}

src_install() {
	insinto /boot
	doins bootcode.bin boot/fixup*.dat boot/start*.elf
	newins "${FILESDIR}"/${PN}-0_p20130711-config.txt config.txt
	newins "${FILESDIR}"/${PN}-0_p20130711-cmdline.txt cmdline.txt
	newenvd "${FILESDIR}"/${PN}-0_p20130711-envd 90${PN}
	readme.gentoo_create_doc
}

DOC_CONTENTS="Please configure your ram setup by editing /boot/config.txt"
