# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/folks/folks-0.9.2.ebuild,v 1.3 2013/07/24 22:16:48 eva Exp $

EAPI="5"
GCONF_DEBUG="yes"
VALA_MIN_API_VERSION="0.18"
VALA_USE_DEPEND="vapigen"

inherit gnome2 vala virtualx

DESCRIPTION="Library for aggregating people from multiple sources"
HOMEPAGE="https://live.gnome.org/Folks"

LICENSE="LGPL-2.1+"
SLOT="0/25" # subslot = libfolks soname version
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-linux"
# TODO: --enable-profiling
IUSE="eds socialweb +telepathy test tracker utils vala zeitgeist"

COMMON_DEPEND="
	>=dev-libs/glib-2.32:2
	dev-libs/dbus-glib
	>=dev-libs/libgee-0.10:0.8[introspection]
	dev-libs/libxml2
	sys-libs/ncurses:=
	sys-libs/readline:=

	eds? ( >=gnome-extra/evolution-data-server-3.8.1:= )
	socialweb? ( >=net-libs/libsocialweb-0.25.20 )
	telepathy? ( >=net-libs/telepathy-glib-0.19 )
	tracker? ( >=app-misc/tracker-0.16:= )
	zeitgeist? ( >=dev-libs/libzeitgeist-0.3.14:= )
"
# telepathy-mission-control needed at runtime; it is used by the telepathy
# backend via telepathy-glib's AccountManager binding.
RDEPEND="${COMMON_DEPEND}
	net-im/telepathy-mission-control
"
# folks socialweb backend requires that libsocialweb be built with USE=vala,
# even when building folks with --disable-vala.
DEPEND="${COMMON_DEPEND}
	>=dev-libs/gobject-introspection-1.30
	>=dev-util/intltool-0.50.0
	sys-devel/gettext
	virtual/pkgconfig

	socialweb? ( >=net-libs/libsocialweb-0.25.15[vala] )
	test? ( sys-apps/dbus )
	vala? (
		$(vala_depend)
		eds? ( >=gnome-extra/evolution-data-server-3.8.1:=[vala] )
		telepathy? ( >=net-libs/telepathy-glib-0.19[vala] ) )
"
# the inspect tool requires --enable-vala
REQUIRED_USE="utils? ( vala )"

src_prepare() {
	use vala && vala_src_prepare
	gnome2_src_prepare
}

src_configure() {
	# Rebuilding docs needs valadoc, which has no release
	gnome2_src_configure \
		$(use_enable eds eds-backend) \
		$(use_enable eds ofono-backend) \
		$(use_enable socialweb libsocialweb-backend) \
		$(use_enable telepathy telepathy-backend) \
		$(use_enable tracker tracker-backend) \
		$(use_enable utils inspect-tool) \
		$(use_enable vala) \
		$(use_enable test tests) \
		$(use_enable zeitgeist) \
		--enable-import-tool \
		--disable-docs \
		--disable-fatal-warnings
}

src_test() {
	dbus-launch Xemake check
}
