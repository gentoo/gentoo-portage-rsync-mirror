# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/obex-data-server/obex-data-server-0.4.4.ebuild,v 1.11 2012/11/20 07:57:16 pinkbyte Exp $

EAPI="2"

DESCRIPTION="A DBus service providing easy to use API for using OBEX"
HOMEPAGE="http://tadas.dailyda.com/blog/category/obex-data-server/"
SRC_URI="http://tadas.dailyda.com/software/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ~ppc x86"

IUSE="debug gtk imagemagick usb"

# usb? ( virtual/libusb:0 ) is broken, will work only in 0.4.6
RDEPEND="dev-libs/glib:2
	>=dev-libs/dbus-glib-0.7
	sys-apps/dbus
	>=net-wireless/bluez-4.31
	>=dev-libs/openobex-1.3
	imagemagick? ( !gtk? ( media-gfx/imagemagick ) )
	gtk? ( x11-libs/gtk+:2 )
	virtual/libusb:0
	!app-mobilephone/obexd[server]"
DEPEND="virtual/pkgconfig
	${RDEPEND}"

src_configure() {
	local bip="no"
	use imagemagick && bip="magick"
	use gtk && bip="gdk-pixbuf"
	econf \
		--enable-bip=${bip} \
		$(use_enable usb) \
		--disable-system-config \
		$(use_enable debug)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
