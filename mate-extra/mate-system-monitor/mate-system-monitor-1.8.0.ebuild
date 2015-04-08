# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mate-extra/mate-system-monitor/mate-system-monitor-1.8.0.ebuild,v 1.5 2014/07/02 09:48:18 pacho Exp $

EAPI="5"

GCONF_DEBUG="no"

inherit gnome2 versionator

MATE_BRANCH="$(get_version_component_range 1-2)"

SRC_URI="http://pub.mate-desktop.org/releases/${MATE_BRANCH}/${P}.tar.xz"
DESCRIPTION="The MATE System Monitor"
HOMEPAGE="http://mate-desktop.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND="app-text/rarian:0
	>=dev-cpp/glibmm-2.16:2
	>=dev-cpp/gtkmm-2.22:2.4
	>=dev-libs/dbus-glib-0.70:0
	>=dev-libs/glib-2.28:2
	dev-libs/libsigc++:2
	>=dev-libs/libxml2-2:2
	>=gnome-base/libgtop-2.23.1:2=
	>=gnome-base/librsvg-2.12:2
	>=sys-apps/dbus-0.7:0
	x11-libs/cairo:0
	x11-libs/gdk-pixbuf:2
	>=x11-libs/gtk+-2.20:2
	>=x11-libs/libwnck-2.5:1
	>=x11-themes/mate-icon-theme-1.6:0
	virtual/libintl:0"

DEPEND="${RDEPEND}
	>=app-text/scrollkeeper-dtd-1:1.0
	app-text/yelp-tools:0
	>=dev-util/intltool-0.35:*
	sys-devel/gettext:*
	virtual/pkgconfig:*"

DOCS="AUTHORS ChangeLog NEWS README"
