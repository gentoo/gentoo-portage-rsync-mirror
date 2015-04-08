# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gnome-chess/gnome-chess-3.12.3.ebuild,v 1.3 2014/07/23 15:16:13 ago Exp $

EAPI="5"
GCONF_DEBUG="no"
VALA_MIN_API_VERSION="0.24"

inherit gnome-games vala

DESCRIPTION="Play the classic two-player boardgame of chess"
HOMEPAGE="https://wiki.gnome.org/Apps/Chess"

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="amd64 ~arm x86"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	>=gnome-base/librsvg-2.32
	virtual/glu
	virtual/opengl
	>=x11-libs/gtk+-3.10:3
	x11-libs/libX11
"
DEPEND="${RDEPEND}
	$(vala_depend)
	app-text/yelp-tools
	>=dev-util/intltool-0.50
	sys-devel/gettext
	virtual/pkgconfig
"

src_prepare() {
	vala_src_prepare
	gnome-games_src_prepare
}
