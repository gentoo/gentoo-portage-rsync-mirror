# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gnome-mahjongg/gnome-mahjongg-3.8.0.ebuild,v 1.2 2013/08/31 10:39:47 pinkbyte Exp $

EAPI=5
GCONF_DEBUG="no"
VALA_MIN_API_VERSION="0.16"

inherit gnome-games vala

DESCRIPTION="Disassemble a pile of tiles by removing matching pairs"
HOMEPAGE="https://wiki.gnome.org/Mahjongg"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~arm"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	>=gnome-base/librsvg-2.32.0
	>=x11-libs/gtk+-3.4.0:3
"
DEPEND="${RDEPEND}
	$(vala_depend)
	app-text/yelp-tools
	>=dev-util/intltool-0.35.0
	virtual/pkgconfig
"

src_prepare() {
	gnome-games_src_prepare
	vala_src_prepare
}
