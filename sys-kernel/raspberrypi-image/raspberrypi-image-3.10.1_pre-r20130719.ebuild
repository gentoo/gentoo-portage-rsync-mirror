# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/raspberrypi-image/raspberrypi-image-3.10.1_pre-r20130719.ebuild,v 1.1 2013/07/23 19:17:36 xmw Exp $

EAPI=5

DESCRIPTION="Raspberry PI precompiled kernel and modules"
HOMEPAGE="https://github.com/raspberrypi/firmware"
SRC_URI="https://dev.gentoo.org/~xmw/${PN}/${PF}.tar.bz2"

LICENSE="GPL-2"
SLOT="3.10.1-raspberrypi-${PR}"
KEYWORDS="~arm -*"
IUSE=""

S=${WORKDIR}

RESTRICT="binchecks mirror strip"

src_install() {
	insinto /boot
	doins boot/*

	insinto /lib
	doins -r lib/modules
}
