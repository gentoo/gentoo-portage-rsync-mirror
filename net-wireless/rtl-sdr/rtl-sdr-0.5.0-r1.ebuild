# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/rtl-sdr/rtl-sdr-0.5.0-r1.ebuild,v 1.1 2013/06/27 04:25:33 zerochaos Exp $

EAPI=5

inherit autotools udev

DESCRIPTION="turns your Realtek RTL2832 based DVB dongle into a SDR receiver"
HOMEPAGE="http://sdr.osmocom.org/trac/wiki/rtl-sdr"

if [[ ${PV} == 9999* ]]; then
	inherit git-2
	SRC_URI=""
	EGIT_REPO_URI="git://git.osmocom.org/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://dev.gentoo.org/~zerochaos/distfiles/${P}.tar.xz"
	KEYWORDS="~amd64 ~arm ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND="virtual/libusb:1"
DEPEND="${RDEPEND}"

DOCS=( ${PN}.rules )

src_unpack() {
	if [[ ${PV} == 9999* ]]; then
		git-2_src_unpack
	else
		default
		mv ${PN} ${P} || die
	fi
}

src_prepare() {
	eautoreconf
}

src_install() {
	udev_dorules rtl-sdr.rules
	default
	rm "${ED}"/usr/share/doc/${PF}/rtl-sdr.rules
}
