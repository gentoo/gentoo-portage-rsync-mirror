# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/gcdemu/gcdemu-1.5.0.ebuild,v 1.5 2013/01/28 00:24:30 tetromino Exp $

EAPI="4"

PYTHON_DEPEND="2:2.6"

inherit gnome2 python

DESCRIPTION="Gtk+ GUI for controlling cdemu-daemon"
HOMEPAGE="http://cdemu.org/"
SRC_URI="mirror://sourceforge/cdemu/${P}.tar.bz2"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="~app-cdr/cdemu-daemon-${PV}
	>=dev-libs/glib-2.28:2
	dev-libs/gobject-introspection
	dev-python/pygobject:3
	sys-apps/dbus
	x11-libs/gdk-pixbuf[introspection]
	x11-libs/gtk+:3[introspection]
	x11-libs/libnotify[introspection]"
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.21
	virtual/pkgconfig
	sys-devel/gettext"

DOCS="AUTHORS ChangeLog README"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	python_convert_shebangs 2 src/gcdemu
	gnome2_src_prepare
}
