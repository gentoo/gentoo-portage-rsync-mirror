# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/lightsoff/lightsoff-3.12.2.ebuild,v 1.3 2014/07/23 15:16:31 ago Exp $

EAPI="5"
GCONF_DEBUG="no"
VALA_MIN_API_VERSION="0.22"

inherit gnome-games vala

DESCRIPTION="Turn off all the lights"
HOMEPAGE="https://wiki.gnome.org/Apps/Lightsoff"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 ~arm x86"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	>=media-libs/clutter-1.14:1.0
	>=media-libs/clutter-gtk-1.4:1.0
	>=x11-libs/gtk+-3.10:3
"
DEPEND="${RDEPEND}
	$(vala_depend)
	app-text/yelp-tools
	>=dev-util/intltool-0.50
	sys-devel/gettext
	virtual/pkgconfig
"

src_prepare() {
	gnome-games_src_prepare
	vala_src_prepare
}
