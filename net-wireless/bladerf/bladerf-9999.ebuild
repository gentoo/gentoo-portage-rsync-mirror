# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/bladerf/bladerf-9999.ebuild,v 1.1 2014/07/25 03:46:40 zerochaos Exp $

EAPI=5

inherit git-r3 cmake-utils udev

DESCRIPTION="Libraries for supporing the BladeRF hardware from Nuand"
HOMEPAGE="http://nuand.com/"
EGIT_REPO_URI="https://github.com/Nuand/bladeRF.git"

#lib is LGPL and cli tools are GPL
LICENSE="GPL-2+ LGPL-2.1+"

SLOT="0"
KEYWORDS=""
IUSE=""

CDEPEND=">=dev-libs/libusb-1.0.16"
DEPEND="${CDEPEND}
	virtual/pkgconfig"
RDEPEND="${CDEPEND}"
PDEPEND="net-wireless/bladerf-firmware
	net-wireless/bladerf-fpga"

src_configure() {
	mycmakeargs=(
		-DTREAT_WARNINGS_AS_ERRORS=OFF
		-DUDEV_RULES_PATH="$(get_udevdir)"/rules.d
	)
	cmake-utils_src_configure
}
