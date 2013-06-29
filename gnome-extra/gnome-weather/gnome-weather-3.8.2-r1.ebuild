# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-weather/gnome-weather-3.8.2-r1.ebuild,v 1.1 2013/06/29 21:01:55 pacho Exp $

EAPI="5"
GCONF_DEBUG="no"

inherit eutils gnome2

DESCRIPTION="A weather application for GNOME"
HOMEPAGE="https://live.gnome.org/Design/Apps/Weather"

LICENSE="GPL-2+ LGPL-2+ MIT CC-BY-3.0 CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-libs/gjs
	dev-libs/glib:2
	>=dev-libs/gobject-introspection-1.35.9
"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.26
	virtual/pkgconfig
"

src_prepare() {
	# Add a submenu to the app menu to choose the temperature unit (from 'master')
	epatch "${FILESDIR}/${PN}-3.8.2-temp-unit.patch"

	gnome2_src_prepare
}
