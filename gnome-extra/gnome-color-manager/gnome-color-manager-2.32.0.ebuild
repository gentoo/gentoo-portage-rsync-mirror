# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-color-manager/gnome-color-manager-2.32.0.ebuild,v 1.12 2014/07/24 18:36:03 ssuominen Exp $

EAPI="3"
GCONF_DEBUG="no"

inherit eutils gnome2

DESCRIPTION="Color profile manager for the GNOME desktop"
HOMEPAGE="http://projects.gnome.org/gnome-color-manager/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc"

RDEPEND=">=dev-libs/glib-2.14:2
	>=dev-libs/dbus-glib-0.73
	>=dev-libs/libunique-1:1
	>=gnome-base/gconf-2
	>=gnome-base/gnome-desktop-2.14:2
	media-gfx/sane-backends
	media-libs/lcms:0
	media-libs/libcanberra[gtk]
	media-libs/tiff
	net-print/cups
	virtual/libgudev
	x11-libs/libX11
	x11-libs/libXxf86vm
	x11-libs/libXrandr
	>=x11-libs/gtk+-2.14:2
	x11-libs/libnotify
	>=x11-libs/vte-0.22:0
"
DEPEND="${RDEPEND}
	app-text/gnome-doc-utils
	app-text/scrollkeeper
	>=dev-util/intltool-0.35
	doc? ( >=dev-util/gtk-doc-1.9 )
"

# FIXME: run test-suite with files on live file-system
RESTRICT="test"

pkg_setup() {
	# Always enable tests since they are check_PROGRAMS anyway
	G2CONF="${G2CONF} --enable-tests --disable-packagekit"
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-libnotify-0.7.patch
	gnome2_src_prepare
}
