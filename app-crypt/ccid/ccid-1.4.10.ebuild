# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/ccid/ccid-1.4.10.ebuild,v 1.1 2013/04/17 21:51:48 flameeyes Exp $

EAPI=5

STUPID_NUM="3897"

inherit eutils toolchain-funcs udev autotools-utils

DESCRIPTION="CCID free software driver"
HOMEPAGE="http://pcsclite.alioth.debian.org/ccid.html"
SRC_URI="http://alioth.debian.org/download.php/${STUPID_NUM}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="twinserial +usb"

RDEPEND=">=sys-apps/pcsc-lite-1.8.3
	usb? ( virtual/libusb:1 )"
DEPEND="${RDEPEND}
	kernel_linux? ( virtual/pkgconfig )"

DOCS=( README AUTHORS )

src_prepare() {
	sed -i -e 's:GROUP="pcscd":ENV{PCSCD}="1":' \
		src/92_pcscd_ccid.rules || die

	autotools-utils_src_prepare
}

src_configure() {
	local myeconfargs=(
		LEX=:
		$(use_enable twinserial)
		$(use_enable usb libusb)
	)

	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install

	if use kernel_linux; then
		# note: for eudev support, rules probably will always need to be installed to /usr
		udev_newrules src/92_pcscd_ccid.rules 92-pcsc-ccid.rules
	fi
}
