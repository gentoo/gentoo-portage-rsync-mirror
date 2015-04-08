# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gnome-chess/gnome-chess-3.14.3.ebuild,v 1.3 2015/03/15 13:20:29 pacho Exp $

EAPI="5"
GCONF_DEBUG="no"
VALA_MIN_API_VERSION="0.24"

inherit gnome-games vala readme.gentoo

DESCRIPTION="Play the classic two-player boardgame of chess"
HOMEPAGE="https://wiki.gnome.org/Apps/Chess"

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="amd64 ~arm x86"
IUSE=""

RDEPEND="
	>=dev-libs/glib-2.40:2
	>=gnome-base/librsvg-2.32
	>=x11-libs/gtk+-3.13.2:3
"
DEPEND="${RDEPEND}
	$(vala_depend)
	app-text/yelp-tools
	dev-util/appdata-tools
	>=dev-util/intltool-0.50
	sys-devel/gettext
	virtual/pkgconfig
"

DOC_CONTENTS="For being able to play against computer you will
	need to install a chess engine like, for example, games-board/gnuchess"

src_prepare() {
	vala_src_prepare
	gnome-games_src_prepare
}

src_configure() {
	gnome-games_src_configure APPDATA_VALIDATE=$(type -P true)
}

src_install() {
	gnome-games_src_install
	readme.gentoo_create_doc
}

pkg_postinst() {
	gnome-games_pkg_postinst
	readme.gentoo_print_elog
}
