# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/usbmuxd/usbmuxd-1.0.8-r1.ebuild,v 1.7 2013/02/02 22:23:47 ago Exp $

EAPI=4
inherit cmake-utils user udev

DESCRIPTION="USB multiplex daemon for use with Apple iPhone/iPod Touch devices"
HOMEPAGE="http://www.libimobiledevice.org/"
SRC_URI="http://www.libimobiledevice.org/downloads/${P}.tar.bz2"

LICENSE="GPL-2 GPL-3 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86"
IUSE=""

RDEPEND=">=app-pda/libplist-1.8-r1
	virtual/libusb:1"
DEPEND="${RDEPEND}
	virtual/os-headers
	virtual/pkgconfig"

pkg_setup() {
	enewgroup plugdev
	enewuser usbmux -1 -1 -1 "usb,plugdev"
}

src_configure() {
	if [[ $(udev_get_udevdir) != "/lib/udev" ]]; then
		sed -i -e "/rules/s:/lib/udev:$(udev_get_udevdir):" udev/CMakeLists.txt || die
	fi

	cmake-utils_src_configure
}

DOCS="AUTHORS README README.devel"
