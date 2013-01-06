# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-documents/gnome-documents-0.4.2.ebuild,v 1.1 2012/05/19 23:10:54 tetromino Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="GNOME document manager"
HOMEPAGE="https://live.gnome.org/Design/Apps/Documents"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

# Need gdk-pixbuf-2.25 for gdk_pixbuf_get_pixels_with_length
COMMON_DEPEND="
	>=app-misc/tracker-0.13.1
	>=app-text/evince-3.3.0[introspection]
	dev-libs/gjs
	>=dev-libs/glib-2.31.6:2
	>=dev-libs/gobject-introspection-1.31.6
	>=dev-libs/libgdata-0.11.0[introspection]
	gnome-base/gnome-desktop:3
	>=media-libs/clutter-gtk-1.0.2:1.0[introspection]
	>=net-libs/gnome-online-accounts-3.2.0
	net-libs/liboauth
	net-libs/libsoup:2.4
	>=x11-libs/gdk-pixbuf-2.25:2[introspection]
	>=x11-libs/gtk+-3.3.6:3[introspection]
	x11-libs/pango[introspection]"
RDEPEND="${COMMON_DEPEND}
	media-libs/clutter[introspection]
	sys-apps/dbus
	x11-themes/gnome-icon-theme-symbolic"
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.40
	>=sys-devel/gettext-0.17
	virtual/pkgconfig"

pkg_setup() {
	DOCS="AUTHORS NEWS README TODO"
	G2CONF="${G2CONF} --disable-schemas-compile"
}
