# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gom/gom-0.2.1.ebuild,v 1.1 2014/09/02 13:35:14 pacho Exp $

EAPI="5"
GCONF_DEBUG="yes"

inherit gnome2

DESCRIPTION="GObject to SQLite object mapper library"
HOMEPAGE="https://wiki.gnome.org/Projects/Gom"

LICENSE="LGPL-2+"
SLOT="0"

IUSE="+introspection"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-db/sqlite-3.7:3
	>=dev-libs/glib-2.36:2
	x11-libs/gdk-pixbuf:2
	introspection? ( >=dev-libs/gobject-introspection-1.30.0 )
"
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.14
	>=dev-util/intltool-0.40.0
	sys-devel/gettext
	virtual/pkgconfig
"

src_configure() {
	gnome2_src_configure $(use_enable introspection)
}
