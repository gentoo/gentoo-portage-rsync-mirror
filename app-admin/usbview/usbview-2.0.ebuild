# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/usbview/usbview-2.0.ebuild,v 1.10 2013/02/12 22:01:54 jer Exp $

EAPI=4
inherit eutils linux-info

DESCRIPTION="Display the topology of devices on the USB bus"
HOMEPAGE="http://www.kroah.com/linux-usb/"
SRC_URI="http://www.kroah.com/linux-usb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc ppc64 sparc x86"
IUSE=""

RDEPEND="x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README TODO"

pkg_setup() {
	CONFIG_CHECK="~DEBUG_FS"
	linux-info_pkg_setup
}

src_install() {
	default
	doicon usb_icon.xpm
	make_desktop_entry ${PN} 'USB Viewer' usb_icon
}
