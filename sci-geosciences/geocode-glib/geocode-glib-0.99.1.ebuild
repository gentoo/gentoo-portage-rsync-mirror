# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/geocode-glib/geocode-glib-0.99.1.ebuild,v 1.2 2013/08/02 21:00:39 eva Exp $

EAPI=5
GCONF_DEBUG="no" # --enable-debug does not do anything useful

inherit gnome2

DESCRIPTION="GLib geocoding library that uses the Yahoo! Place Finder service"
HOMEPAGE="http://git.gnome.org/browse/geocode-glib"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="+introspection test"

RDEPEND="
	dev-libs/geoip
	>=dev-libs/glib-2.34:2
	>=dev-libs/json-glib-0.14[introspection?]
	gnome-base/gvfs[http]
	net-libs/libsoup:2.4[introspection?]
	introspection? (
		>=dev-libs/gobject-introspection-0.6.3
		|| ( >=net-libs/libsoup-2.42:2.4 net-libs/libsoup-gnome:2.4[introspection] ) )
"
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.13
	>=dev-util/intltool-0.41.0
	>=sys-devel/gettext-0.17
	virtual/pkgconfig
	test? ( sys-apps/dbus )
"
# eautoreconf requires:
#	dev-libs/gobject-introspection-common
#	gnome-base/gnome-common

RESTRICT="test" # Need network #424719

#src_test() {
#	export GVFS_DISABLE_FUSE=1
#	export GIO_USE_VFS=gvfs
#	ewarn "Tests require network access to http://where.yahooapis.com"
#	dbus-launch emake check || die "tests failed"
#}
