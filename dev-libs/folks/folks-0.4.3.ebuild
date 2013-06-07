# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/folks/folks-0.4.3.ebuild,v 1.9 2013/06/07 03:14:17 tetromino Exp $

EAPI="5"
GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"
GNOME_TARBALL_SUFFIX="bz2"
VALA_MIN_API_VERSION="0.16" # see bug #464500
VALA_USE_DEPEND="vapigen"

inherit gnome2 vala

DESCRIPTION="libfolks is a library that aggregates people from multiple sources"
HOMEPAGE="http://telepathy.freedesktop.org/wiki/Folks"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc x86 ~x86-linux"
IUSE=""

# FIXME: links against system libfolks instead of the built one
RDEPEND=">=dev-libs/glib-2.24:2
	>=net-libs/telepathy-glib-0.13.1[vala]
	dev-libs/dbus-glib
	<dev-libs/libgee-0.7:0
	dev-libs/libxml2
	sys-libs/ncurses:=
	sys-libs/readline:=
"
DEPEND="${RDEPEND}
	$(vala_depend)
	>=dev-util/intltool-0.35.0
	virtual/pkgconfig
	>=dev-libs/gobject-introspection-0.9.12
	sys-devel/gettext
"

src_prepare() {
	gnome2_src_prepare
	vala_src_prepare
}

src_configure() {
	gnome2_src_configure \
		--enable-import-tool \
		--enable-inspect-tool \
		--enable-vala \
		--disable-docs \
		--disable-Werror
	# Rebuilding docs needs valadoc, which has no release
}
