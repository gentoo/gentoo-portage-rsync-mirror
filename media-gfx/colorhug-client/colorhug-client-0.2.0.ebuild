# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/colorhug-client/colorhug-client-0.2.0.ebuild,v 1.4 2013/12/08 19:04:32 pacho Exp $

EAPI=5
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="Client tools for the ColorHug display colorimeter"
HOMEPAGE="http://www.hughski.com/"
SRC_URI="http://people.freedesktop.org/~hughsient/releases/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="
	dev-db/sqlite:3
	>=dev-libs/glib-2.31.10:2
	dev-libs/libgusb
	media-libs/lcms:2
	media-libs/libcanberra[gtk3]
	net-libs/libsoup:2.4
	x11-libs/gtk+:3
	>=x11-misc/colord-0.1.31
	>=x11-libs/colord-gtk-0.1.24
"
DEPEND="${RDEPEND}
	app-text/docbook-sgml-dtd:4.1
	app-text/docbook-sgml-utils
	app-text/yelp-tools
	>=dev-util/intltool-0.35
	>=sys-devel/gettext-0.17
	virtual/pkgconfig
"
# docbook stuff needed for man pages

src_configure() {
	# introspection checked but not needed by anything
	gnome2_src_configure --disable-introspection
}
