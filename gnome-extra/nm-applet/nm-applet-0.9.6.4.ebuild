# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/nm-applet/nm-applet-0.9.6.4.ebuild,v 1.4 2013/01/01 14:33:57 ago Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
GNOME_ORG_MODULE="network-manager-applet"

inherit eutils gnome2

DESCRIPTION="GNOME applet for NetworkManager"
HOMEPAGE="http://projects.gnome.org/NetworkManager/"

LICENSE="GPL-2+"
SLOT="0"
IUSE="bluetooth gconf"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~x86"

RDEPEND=">=dev-libs/glib-2.26:2
	>=dev-libs/dbus-glib-0.88
	>=gnome-base/gnome-keyring-2.20
	>=sys-apps/dbus-1.4.1
	>=sys-auth/polkit-0.96-r1
	>=x11-libs/gtk+-3:3
	>=x11-libs/libnotify-0.7.0

	app-text/iso-codes
	>=net-misc/networkmanager-0.9.6
	net-misc/mobile-broadband-provider-info

	bluetooth? ( >=net-wireless/gnome-bluetooth-2.27.6 )
	gconf? ( >=gnome-base/gconf-2.20:2 )
	virtual/freedesktop-icon-theme"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=dev-util/intltool-0.40"

src_prepare() {
	DOCS="AUTHORS ChangeLog NEWS README"
	G2CONF="${G2CONF}
		--with-gtkver=3
		--disable-more-warnings
		--disable-static
		--localstatedir=/var
		$(use_with bluetooth)
		$(use_enable gconf migration)"

	gnome2_src_prepare
}
