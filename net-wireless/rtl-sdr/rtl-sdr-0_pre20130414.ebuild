# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/rtl-sdr/rtl-sdr-0_pre20130414.ebuild,v 1.1 2013/06/01 12:56:33 chithanh Exp $

EAPI=5
inherit autotools

DESCRIPTION="turns your Realtek RTL2832 based DVB dongle into a SDR receiver"
HOMEPAGE="http://sdr.osmocom.org/trac/wiki/rtl-sdr"

if [[ ${PV} == 9999* ]]; then
	inherit git-2
	SRC_URI=""
	EGIT_REPO_URI="git://git.osmocom.org/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="mirror://gentoo/${P}.tar.xz"
	KEYWORDS="~amd64 ~x86"
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
		unpack ${A}
		mv ${PN}-*/ ${P} || die
	fi
}

src_prepare() {
	eautoreconf
}

pkg_postinst() {
	local rulesfiles=( "${EPREFIX}"/etc/udev/rules.d/*${PN}.rules )
	if [[ ! -f ${rulesfiles} ]]; then
		elog "In order to allow users outside the usb group to capture samples, install"
		elog "${PN}.rules from the documentation directory to ${EPREFIX}/etc/udev/rules.d/"
	fi
}
