# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/five-or-more/five-or-more-3.8.2.ebuild,v 1.1 2013/06/30 10:56:08 pacho Exp $

EAPI="5"
GCONF_DEBUG="no"

inherit gnome-games

DESCRIPTION="Five or More Game for GNOME"
HOMEPAGE="https://live.gnome.org/Five%20or%20more"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	>=gnome-base/librsvg-2.32.0
	>=x11-libs/gtk+-3.4.0:3
"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35.0
	dev-util/itstool
	virtual/pkgconfig
"
