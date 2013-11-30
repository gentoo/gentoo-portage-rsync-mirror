# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gnome-mines/gnome-mines-3.8.2.ebuild,v 1.4 2013/11/30 19:01:40 pacho Exp $

EAPI="5"
GCONF_DEBUG="no"
VALA_MIN_API_VERSION="0.16"

inherit gnome-games vala

DESCRIPTION="Clear hidden mines from a minefield"
HOMEPAGE="https://wiki.gnome.org/Mines"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 ~arm ~x86"
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
	sys-devel/gettext
	virtual/pkgconfig
"

src_prepare() {
	gnome-games_src_prepare
	vala_src_prepare
}
