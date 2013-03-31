# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/geocode-glib/geocode-glib-0.99.0.ebuild,v 1.10 2013/03/31 19:07:35 pacho Exp $

EAPI="4"

GNOME2_LA_PUNT="yes"
GNOME_TARBALL_SUFFIX="bz2"
GCONF_DEBUG="no" # --enable-debug does not do anything useful

inherit gnome2

DESCRIPTION="GLib geocoding library that uses the Yahoo! Place Finder service"
HOMEPAGE="http://git.gnome.org/browse/geocode-glib"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="+introspection test"

RDEPEND="dev-libs/glib:2
	>=dev-libs/json-glib-0.13.1[introspection?]
	gnome-base/gvfs[http]
	net-libs/libsoup:2.4[introspection?]
	introspection? (
		>=dev-libs/gobject-introspection-0.6.3
		|| ( >=net-libs/libsoup-2.42:2.4 net-libs/libsoup-gnome:2.4[introspection] ) )
"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35
	sys-devel/gettext
	virtual/pkgconfig
	test? ( sys-apps/dbus )
"
# eautoreconf requires:
#	dev-libs/gobject-introspection-common
#	gnome-base/gnome-common

src_prepare() {
	gnome2_src_prepare

	# Crazy flags
	sed -e 's:-Wall ::' -i configure || die
}

src_test() {
	export GVFS_DISABLE_FUSE=1
	export GIO_USE_VFS=gvfs
	ewarn "Tests require network access to http://where.yahooapis.com"
	dbus-launch emake check || die "tests failed"
}
