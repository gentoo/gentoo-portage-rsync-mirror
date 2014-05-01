# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/hackrf-tools/hackrf-tools-2014.04.1.ebuild,v 1.1 2014/05/01 14:41:52 zerochaos Exp $

EAPI=5

inherit cmake-utils udev

DESCRIPTION="library for communicating with HackRF SDR platform"
HOMEPAGE="http://greatscottgadgets.com/hackrf/"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/mossmann/hackrf.git"
	inherit git-2
	KEYWORDS=""
	EGIT_SOURCEDIR="${WORKDIR}/hackrf"
	S="${WORKDIR}/hackrf/host/hackrf-tools"
else
	S="${WORKDIR}/hackrf-${PV}/host/hackrf-tools"
	SRC_URI="mirror://sourceforge/hackrf/hackrf-${PV}.tar.xz"
	KEYWORDS="~amd64 ~arm ~ppc ~x86"
fi

LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND="virtual/libusb:1
	=net-libs/libhackrf-${PV}:="
RDEPEND="${DEPEND}"

src_install() {
	cmake-utils_src_install
	if [[ ${PV} != "9999" ]] ; then
		insinto /lib/firmware
		newins "${WORKDIR}/hackrf-${PV}/firmware-bin/jawbreaker/hackrf_usb_rom_to_ram.bin" hackrf_jawbreaker_usb_rom_to_ram-${PV}.bin
		newins "${WORKDIR}/hackrf-${PV}/firmware-bin/hackrf-one/hackrf_usb_rom_to_ram.bin" hackrf_one_usb_rom_to_ram-${PV}.bin
	fi
	udev_dorules 52-hackrf.rules
}
