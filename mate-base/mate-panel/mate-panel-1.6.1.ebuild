# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mate-base/mate-panel/mate-panel-1.6.1.ebuild,v 1.1 2014/03/05 14:23:51 tomwij Exp $

EAPI="5"

GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit autotools gnome2 versionator

MATE_BRANCH="$(get_version_component_range 1-2)"

SRC_URI="http://pub.mate-desktop.org/releases/${MATE_BRANCH}/${P}.tar.xz"
DESCRIPTION="The MATE panel"
HOMEPAGE="http://mate-desktop.org"

LICENSE="GPL-2 FDL-1.1 LGPL-2"
SLOT="0"
KEYWORDS="~amd64"

IUSE="X +introspection networkmanager"

RDEPEND="
	dev-libs/atk:0
	>=dev-libs/dbus-glib-0.80:0
	>=dev-libs/glib-2.26:2
	>=dev-libs/libmateweather-1.6
	dev-libs/libxml2:2
	>=gnome-base/dconf-0.10:0
	gnome-base/librsvg:2
	>=mate-base/mate-desktop-1.6:0
	>=mate-base/mate-menus-1.6:0
	>=media-libs/libcanberra-0.23:0[gtk]
	>=sys-apps/dbus-1.1.2:0
	>=x11-libs/cairo-1:0
	>=x11-libs/gdk-pixbuf-2.7.1:2
	x11-libs/libICE:0
	x11-libs/libSM:0
	x11-libs/libX11:0
	>=x11-libs/pango-1.15.4:0[introspection?]
	>=x11-libs/gtk+-2.19.7:2[introspection?]
	>=x11-libs/libmatewnck-1.5.1:0
	x11-libs/libXau:0
	>=x11-libs/libXrandr-1.2:0
	virtual/libintl:0
	introspection? ( >=dev-libs/gobject-introspection-0.6.7:0 )
	networkmanager? ( >=net-misc/networkmanager-0.6:0 )"

DEPEND="${RDEPEND}
	app-text/docbook-xml-dtd:4.1.2
	>=app-text/mate-doc-utils-1.2.1:0
	>=dev-lang/perl-5:0=
	>=dev-util/gtk-doc-1:0
	>=dev-util/intltool-0.40:0
	>=mate-base/mate-common-1.6:0
	sys-devel/gettext:0
	sys-libs/glibc:2.2
	virtual/pkgconfig:0"

src_prepare() {
	# Disable python check.
	sed -e '/AM_PATH_PYTHON/d' -i configure.ac || die

	eautoreconf

	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure \
		--libexecdir=/usr/libexec/mate-applets \
		--disable-deprecation-flags \
		$(use_enable networkmanager network-manager) \
		$(use_enable introspection) \
		$(use_with X x)
}

DOCS="AUTHORS ChangeLog HACKING NEWS README"
