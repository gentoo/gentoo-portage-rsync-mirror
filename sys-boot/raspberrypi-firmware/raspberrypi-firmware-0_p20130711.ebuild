# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/raspberrypi-firmware/raspberrypi-firmware-0_p20130711.ebuild,v 1.1 2013/07/15 06:58:46 xmw Exp $

EAPI=5

inherit readme.gentoo

DESCRIPTION="Raspberry PI boot loader and firmware"
HOMEPAGE="https://github.com/raspberrypi/firmware"
MY_COMMIT="ba8059e890"
SRC_URI=""
for my_src_uri in bootcode.bin fixup{,_cd,_x}.dat start{,_cd,_x}.elf ; do
	SRC_URI="${SRC_URI} https://github.com/raspberrypi/firmware/raw/${MY_COMMIT}/boot/${my_src_uri} -> ${PN}-${MY_COMMIT}-${my_src_uri}"
done

LICENSE="GPL-2 raspberrypi-videocore-bin"
SLOT="0"
KEYWORDS="~arm -*"
IUSE=""

DEPEND=""
RDEPEND="!sys-boot/raspberrypi-loader"

S=${WORKDIR}

RESTRICT="binchecks strip"

src_unpack() { :; }

src_install() {
	insinto /boot
	local a
	for a in ${A} ; do
		newins "${DISTDIR}"/${a} ${a#${P}-}
	done
	newins "${FILESDIR}"/${P}-config.txt config.txt
	newins "${FILESDIR}"/${P}-cmdline.txt cmdline.txt
	newenvd "${FILESDIR}"/${P}-envd 90${PN}
	readme.gentoo_create_doc
}

DOC_CONTENTS="Please configure your ram setup by editing /boot/config.txt"
