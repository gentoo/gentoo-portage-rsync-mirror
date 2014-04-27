# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/five-or-more/five-or-more-3.12.1.ebuild,v 1.1 2014/04/27 16:37:39 eva Exp $

EAPI="5"
GCONF_DEBUG="no"

inherit gnome-games

DESCRIPTION="Five or More Game for GNOME"
HOMEPAGE="https://live.gnome.org/Five%20or%20more"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	>=gnome-base/librsvg-2.32
	>=x11-libs/gtk+-3.10:3
"
DEPEND="${RDEPEND}
	app-text/yelp-tools
	>=dev-util/intltool-0.50
	sys-devel/gettext
	virtual/pkgconfig
"
