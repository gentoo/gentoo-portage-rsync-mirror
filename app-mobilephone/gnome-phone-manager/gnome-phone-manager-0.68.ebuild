# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/gnome-phone-manager/gnome-phone-manager-0.68.ebuild,v 1.3 2012/05/02 20:10:08 jdhore Exp $

EAPI="4"
GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="A program created to allow you to control aspects of your mobile phone from your GNOME 2 desktop"
HOMEPAGE="http://live.gnome.org/PhoneManager"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome"
# telepathy support is considered experimental

RDEPEND=">=dev-libs/glib-2.25.0:2
	>=x11-libs/gtk+-3:3
	>=gnome-base/orbit-2
	>=gnome-base/gconf-2:2
	>=gnome-extra/evolution-data-server-1.2.3
	media-libs/libcanberra[gtk3]
	>=app-mobilephone/gnokii-0.6.28[bluetooth]
	net-wireless/bluez
	dev-libs/dbus-glib
	dev-libs/openobex
	media-libs/libcanberra[gtk]
	>=x11-themes/gnome-icon-theme-2.19.1
	>=net-wireless/gnome-bluetooth-3:2"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35.5
	virtual/pkgconfig"
# gnome-common needed for eautoreconf

pkg_setup() {
	DOCS="README NEWS AUTHORS ChangeLog"
	G2CONF="${G2CONF}
		$(use_enable gnome bluetooth-plugin)
		--disable-telepathy
		--disable-static"
}
