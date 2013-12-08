# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/swell-foop/swell-foop-3.8.2.ebuild,v 1.5 2013/12/08 18:23:58 pacho Exp $

EAPI="5"
GCONF_DEBUG="no"
VALA_MIN_API_VERSION="0.16"

inherit gnome-games vala

DESCRIPTION="Clear the screen by removing groups of colored and shaped tiles"
HOMEPAGE="https://wiki.gnome.org/Swell%20Foop"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 ~arm x86"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	>=media-libs/clutter-1:1.0
	>=media-libs/clutter-gtk-0.91.6:1.0
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
