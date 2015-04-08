# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-contacts/gnome-contacts-3.12.0.ebuild,v 1.3 2014/07/23 15:18:05 ago Exp $

EAPI="5"
GCONF_DEBUG="no"
VALA_USE_DEPEND="vapigen"
VALA_MIN_API_VERSION="0.24"

inherit gnome2 vala

DESCRIPTION="GNOME contact management application"
HOMEPAGE="https://wiki.gnome.org/Design/Apps/Contacts"

LICENSE="GPL-2+"
SLOT="0"
IUSE="v4l"
KEYWORDS="~alpha amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc x86"

VALA_DEPEND="
	$(vala_depend)
	>=dev-libs/gobject-introspection-0.9.6
	dev-libs/folks[vala(+)]
	gnome-base/gnome-desktop[introspection]
	gnome-extra/evolution-data-server[vala]
	net-libs/telepathy-glib[vala]
	x11-libs/libnotify[introspection]
"
# Configure is wrong; it needs cheese-3.5.91, not 3.3.91
RDEPEND="
	>=dev-libs/folks-0.9.5:=[eds,telepathy]
	>=dev-libs/glib-2.37.6:2
	>=dev-libs/libgee-0.10:0.8
	>=gnome-extra/evolution-data-server-3.5.3:=[gnome-online-accounts]
	>=gnome-base/gnome-desktop-3.0:3=
	net-libs/gnome-online-accounts
	>=net-libs/telepathy-glib-0.17.5
	x11-libs/cairo:=
	x11-libs/gdk-pixbuf:2
	x11-libs/libnotify:=
	>=x11-libs/gtk+-3.12:3
	x11-libs/pango
	v4l? ( >=media-video/cheese-3.5.91:= )
"
DEPEND="${RDEPEND}
	${VALA_DEPEND}
	dev-libs/libxslt
	>=dev-util/intltool-0.40
	>=sys-devel/gettext-0.17
	virtual/pkgconfig
"

src_prepare() {
	# Regenerate the pre-generated C sources, bug #471628
	if ! use v4l; then
		touch src/*.vala
	fi

	vala_src_prepare
	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure $(use_with v4l cheese)
}
