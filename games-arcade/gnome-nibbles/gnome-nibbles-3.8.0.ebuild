# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/gnome-nibbles/gnome-nibbles-3.8.0.ebuild,v 1.2 2013/08/31 15:30:09 pinkbyte Exp $

EAPI="5"
GCONF_DEBUG="no"

inherit gnome-games

DESCRIPTION="Nibbles clone for Gnome"
HOMEPAGE="https://wiki.gnome.org/Nibbles"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~arm"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	>=gnome-base/librsvg-2.32:2
	>=media-libs/clutter-1:1.0
	>=media-libs/clutter-gtk-0.91.6:1.0
	>=media-libs/libcanberra-0.26[gtk3]
	>=x11-libs/gtk+-3.4:3
"
DEPEND="${RDEPEND}
	app-text/yelp-tools
	>=dev-util/intltool-0.35.0
	sys-devel/gettext
	virtual/pkgconfig
"
