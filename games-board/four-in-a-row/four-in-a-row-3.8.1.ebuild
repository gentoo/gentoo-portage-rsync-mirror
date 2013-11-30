# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/four-in-a-row/four-in-a-row-3.8.1.ebuild,v 1.4 2013/11/30 19:00:56 pacho Exp $

EAPI="5"
GCONF_DEBUG="no"

inherit gnome-games

DESCRIPTION="Make lines of the same color to win"
HOMEPAGE="https://wiki.gnome.org/Four-in-a-row"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 ~arm ~x86"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	>=gnome-base/librsvg-2.32.0
	>=media-libs/libcanberra-0.26[gtk3]
	sys-libs/zlib
	>=x11-libs/gtk+-3.4.0:3
"
DEPEND="${RDEPEND}
	app-text/yelp-tools
	>=dev-util/intltool-0.35.0
	virtual/pkgconfig
"
