# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/raspberrypi-image/raspberrypi-image-3.9.10_pre20130719.ebuild,v 1.1 2013/07/23 11:14:51 xmw Exp $

EAPI=5

inherit vcs-snapshot

DESCRIPTION="Raspberry PI precompiled kernel and modules"
HOMEPAGE="https://github.com/raspberrypi/firmware"
MY_COMMIT="c26501f38b"
SRC_URI="https://github.com/raspberrypi/firmware/tarball/${MY_COMMIT} ->
	raspberrypi-firmware-${MY_COMMIT}.tar.gz"

LICENSE="GPL-2 raspberrypi-videocore-bin"
SLOT="3.9.10"
KEYWORDS="~arm -*"
IUSE="doc"

S=${WORKDIR}/raspberrypi-firmware-${MY_COMMIT}

RESTRICT="binchecks strip"

src_install() {
	insinto /boot
	local suffix
	for suffix in "" "_emergency" ; do
		newins boot/kernel${suffix}.img kernel-${SLOT}${suffix}+.img
		newins extra/System${suffix}.map System-${SLOT}${suffix}+.map
		newins extra/Module${suffix}.symvers Module-${SLOT}${suffix}+.symvers
	done

	insinto /lib/modules
	doins -r modules/${SLOT}+

	if use doc ; then
		dohtml documentation/ilcomponents/*
	fi
}
