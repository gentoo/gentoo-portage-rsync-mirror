# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-documents/gnome-documents-3.8.3.ebuild,v 1.1 2013/06/10 07:56:40 pacho Exp $

EAPI="5"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="A document manager application for GNOME"
HOMEPAGE="https://live.gnome.org/Design/Apps/Documents"

LICENSE="GPL-2+"
SLOT="0"
IUSE=""
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86"

# Need gdk-pixbuf-2.25 for gdk_pixbuf_get_pixels_with_length
COMMON_DEPEND="
	>=app-misc/tracker-0.16:=
	>=app-text/evince-3.7.4[introspection]
	dev-libs/gjs
	>=dev-libs/glib-2.35.1:2
	>=dev-libs/gobject-introspection-1.31.6
	>=dev-libs/libgdata-0.13.3[gnome,introspection]
	gnome-base/gnome-desktop:3=
	>=media-libs/clutter-1.10:1.0
	>=media-libs/clutter-gtk-1.3.2:1.0[introspection]
	>=net-libs/gnome-online-accounts-3.2.0
	>=net-libs/libsoup-2.41.3:2.4
	>=net-libs/libzapojit-0.0.2
	>=net-libs/webkit-gtk-1.10.0:3
	>=x11-libs/gdk-pixbuf-2.25:2[introspection]
	>=x11-libs/gtk+-3.7.7:3[introspection]
	x11-libs/pango[introspection]
"
RDEPEND="${COMMON_DEPEND}
	media-libs/clutter[introspection]
	sys-apps/dbus
	x11-themes/gnome-icon-theme-symbolic
"
DEPEND="${COMMON_DEPEND}
	dev-libs/libxslt
	>=dev-util/intltool-0.40
	>=sys-devel/gettext-0.17
	virtual/pkgconfig
"
