# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/gnome-nibbles/gnome-nibbles-3.12.2.ebuild,v 1.3 2014/07/23 15:16:06 ago Exp $

EAPI="5"
GCONF_DEBUG="no"

inherit gnome-games

DESCRIPTION="Nibbles clone for Gnome"
HOMEPAGE="https://wiki.gnome.org/Apps/Nibbles"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 ~arm x86"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	>=gnome-base/librsvg-2.32:2
	>=media-libs/clutter-1.14.4:1.0
	>=media-libs/clutter-gtk-1.2:1.0
	>=media-libs/libcanberra-0.26[gtk3]
	>=x11-libs/gtk+-3.10:3
"
DEPEND="${RDEPEND}
	app-text/yelp-tools
	>=dev-util/intltool-0.50
	sys-devel/gettext
	virtual/pkgconfig
"
