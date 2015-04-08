# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gdl/gdl-3.14.0.ebuild,v 1.4 2015/03/29 10:30:20 jer Exp $

EAPI="5"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="GNOME docking library"
HOMEPAGE="https://developer.gnome.org/gdl/"

LICENSE="LGPL-2.1+"
SLOT="3/5" # subslot = libgdl-3 soname version
IUSE="+introspection"
KEYWORDS="~alpha amd64 hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc x86 ~x86-fbsd"

RDEPEND="
	dev-libs/glib:2
	>=x11-libs/gtk+-3.0.0:3[introspection?]
	>=dev-libs/libxml2-2.4:2
	introspection? ( >=dev-libs/gobject-introspection-0.6.7 )
"
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.4
	>=dev-util/intltool-0.40.4
	virtual/pkgconfig
"

src_configure() {
	DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README"
	gnome2_src_configure $(use_enable introspection)
}
