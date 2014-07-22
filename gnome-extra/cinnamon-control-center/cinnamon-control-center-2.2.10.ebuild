# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/cinnamon-control-center/cinnamon-control-center-2.2.10.ebuild,v 1.2 2014/07/22 10:46:21 ago Exp $

EAPI="5"
GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes" # gmodule is used, which uses dlopen

inherit autotools eutils gnome2

DESCRIPTION="Cinnamons's main interface to configure various aspects of the desktop"
HOMEPAGE="http://cinnamon.linuxmint.com/"
SRC_URI="https://github.com/linuxmint/cinnamon-control-center/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
IUSE="+colord +cups input_devices_wacom socialweb"
KEYWORDS="amd64 ~x86"

# False positives caused by nested configure scripts
QA_CONFIGURE_OPTIONS=".*"

# FIXME: modemmanager is not optional
#        networkmanager is not optional

COMMON_DEPEND="
	>=dev-libs/glib-2.31:2
	dev-libs/libxml2:2
	>=gnome-base/libgnomekbd-2.91.91:0=
	>=gnome-extra/cinnamon-desktop-1.0:0=
	>=gnome-extra/cinnamon-menus-1.0:0=
	>=gnome-extra/cinnamon-settings-daemon-1.0:0=
	>=gnome-extra/nm-applet-0.9.8
	media-libs/fontconfig
	>=media-libs/libcanberra-0.13[gtk3]
	>=media-sound/pulseaudio-1.1[glib]
	net-misc/modemmanager
	>=net-misc/networkmanager-0.8.9[modemmanager]
	>=sys-auth/polkit-0.103
	|| ( >=sys-power/upower-0.9.1 sys-power/upower-pm-utils )
	>=x11-libs/gdk-pixbuf-2.23.0:2
	>=x11-libs/gtk+-3.4.1:3
	>=x11-libs/libnotify-0.7.3:0=
	x11-libs/libX11
	x11-libs/libxklavier
	colord? ( >=x11-misc/colord-0.1.8:0= )
	cups? ( >=net-print/cups-1.4[dbus] )
	input_devices_wacom? (
		>=dev-libs/libwacom-0.7
		>=x11-libs/gtk+-3.8:3
		>=x11-libs/libXi-1.2 )
	socialweb? ( net-libs/libsocialweb )

"
# <gnome-color-manager-3.1.2 has file collisions with g-c-c-3.1.x
# libgnomekbd needed only for gkbd-keyboard-display tool
RDEPEND="${COMMON_DEPEND}
	|| ( ( app-admin/openrc-settingsd sys-auth/consolekit ) >=sys-apps/systemd-31 )
	x11-themes/gnome-icon-theme-symbolic
	colord? ( >=gnome-extra/gnome-color-manager-3 )
	cups? (
		>=app-admin/system-config-printer-gnome-1.3.5
		net-print/cups-pk-helper )
	input_devices_wacom? ( gnome-extra/cinnamon-settings-daemon[input_devices_wacom] )
"

DEPEND="${COMMON_DEPEND}
	app-text/iso-codes
	x11-proto/xproto
	x11-proto/xf86miscproto
	x11-proto/kbproto

	dev-libs/libxslt
	>=dev-util/intltool-0.40.1
	>=sys-devel/gettext-0.17
	virtual/pkgconfig

	gnome-base/gnome-common
"
# Needed for autoreconf
#	gnome-base/gnome-common

src_prepare() {
	# make some panels optional
	epatch "${FILESDIR}"/${PN}-2.2.5-optional.patch
	# fix wrong nm-applet dependency
	epatch "${FILESDIR}"/${PN}-2.2.5-nm-applet.patch
	epatch_user
	eautoreconf
	gnome2_src_prepare
}

src_configure() {
	# --enable-systemd doesn't do anything in $PN-2.2.5
	gnome2_src_configure \
		--disable-update-mimedb \
		--disable-static \
		--enable-documentation \
		$(use_enable colord color) \
		$(use_enable cups) \
		$(use_with socialweb libsocialweb) \
		$(use_enable input_devices_wacom wacom)
}
