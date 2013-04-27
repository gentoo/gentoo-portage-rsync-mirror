# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
#

EAPI="5"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="A weather application for GNOME"
HOMEPAGE="https://live.gnome.org/Design/Apps/Weather"

LICENSE="GPL-2+ LGPL-2+ MIT CC-BY-3.0 CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-libs/gjs
	dev-libs/glib:2
	>=dev-libs/gobject-introspection-1.35.9
"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.26
	virtual/pkgconfig
"
