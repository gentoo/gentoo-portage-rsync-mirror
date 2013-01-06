# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/nemiver/nemiver-0.9.2.ebuild,v 1.6 2012/05/21 18:50:10 tetromino Exp $

EAPI="4"
GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"

inherit eutils gnome2

DESCRIPTION="A gtkmm front end to the GNU Debugger (gdb)"
HOMEPAGE="http://projects.gnome.org/nemiver/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="memoryview"

RDEPEND=">=dev-libs/glib-2.16:2
	>=dev-cpp/glibmm-2.30:2
	>=dev-cpp/gtkmm-3:3.0
	>=dev-cpp/gtksourceviewmm-3:3.0
	>=gnome-base/gsettings-desktop-schemas-0.0.1
	>=gnome-base/libgtop-2.19
	>=x11-libs/vte-0.28:2.90
	>=dev-db/sqlite-3:3
	sys-devel/gdb
	dev-libs/boost
	memoryview? ( >=app-editors/ghex-2.90:2 )"
# FIXME: dynamiclayout needs unreleased stable gdlmm:3
# dynamiclayout? ( >=dev-cpp/gdlmm-3.0:3 )
DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=sys-devel/gettext-0.17
	>=dev-util/intltool-0.40
	>=app-text/scrollkeeper-0.3.11
	>=app-text/gnome-doc-utils-0.3.2
	app-text/docbook-xml-dtd:4.1.2"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README TODO"
	G2CONF="${G2CONF}
		--disable-symsvis
		--disable-dynamiclayout
		--enable-gsettings
		$(use_enable memoryview)
		--disable-static"
}

src_prepare() {
	# Fix XML validation, bug #413143
	epatch "${FILESDIR}/${P}-xml-validation.patch"
	gnome2_src_prepare
}
