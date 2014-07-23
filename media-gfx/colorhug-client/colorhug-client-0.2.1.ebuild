# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/colorhug-client/colorhug-client-0.2.1.ebuild,v 1.3 2014/07/23 15:18:47 ago Exp $

EAPI=5
GCONF_DEBUG="no"

inherit bash-completion-r1 eutils gnome2

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
	>=x11-misc/colord-0.1.31:0=
	>=x11-libs/colord-gtk-0.1.24
"
DEPEND="${RDEPEND}
	app-text/docbook-sgml-dtd:4.1
	app-text/docbook-sgml-utils
	app-text/yelp-tools
	>=dev-util/intltool-0.50
	>=sys-devel/gettext-0.17
	virtual/pkgconfig
"
# docbook stuff needed for man pages

src_prepare() {
	# from 0.2.2 - fixes build with colord-1.2
	epatch "${FILESDIR}/${P}-colord-1.2.patch"
	gnome2_src_prepare

	# Fix completiondir, avoid eautoreconf
	sed -i "s|^bashcompletiondir =.*|bashcompletiondir = $(get_bashcompdir)|" \
		data/Makefile.in || die "sed bashcompletiondir failed"
}

src_configure() {
	# introspection checked but not needed by anything
	gnome2_src_configure --disable-introspection
}
