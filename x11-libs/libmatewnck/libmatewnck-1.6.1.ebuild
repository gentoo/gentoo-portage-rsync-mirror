# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libmatewnck/libmatewnck-1.6.1.ebuild,v 1.4 2014/05/04 14:55:27 ago Exp $

EAPI="5"

GNOME2_LA_PUNT="yes"
GCONF_DEBUG="no"

inherit gnome2 versionator

MATE_BRANCH="$(get_version_component_range 1-2)"

SRC_URI="http://pub.mate-desktop.org/releases/${MATE_BRANCH}/${P}.tar.xz"
DESCRIPTION="A window navigation construction kit for MATE"
HOMEPAGE="http://www.mate-desktop.org/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64"

IUSE="X +introspection startup-notification"

RDEPEND="dev-libs/atk:0
	>=dev-libs/glib-2.16:2
	x11-libs/cairo:0
	x11-libs/gdk-pixbuf:2
	>=x11-libs/gtk+-2.19.7:2[introspection?]
	x11-libs/libX11:0
	x11-libs/libXext:0
	x11-libs/libXres:0
	x11-libs/pango:0
	virtual/libintl:0
	introspection? ( >=dev-libs/gobject-introspection-0.6.14:0 )
	startup-notification? ( >=x11-libs/startup-notification-0.4:0 )"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40:*
	>=mate-base/mate-common-1.6:0
	sys-devel/gettext:*
	virtual/pkgconfig:*"

src_configure() {
	gnome2_src_configure \
		$(use_enable introspection) \
		$(use_enable startup-notification) \
		$(use_with X x)
}

DOCS="AUTHORS ChangeLog HACKING NEWS README"
