# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gtkhtml/gtkhtml-4.4.3.ebuild,v 1.9 2013/03/29 22:46:26 eva Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2 eutils

DESCRIPTION="Lightweight HTML rendering/printing/editing engine"
HOMEPAGE="http://projects.gnome.org/evolution/"

LICENSE="GPL-2+ LGPL-2+"
SLOT="4.0"
KEYWORDS="sh sparc"
IUSE=""

# orbit is referenced in configure, but is not used anywhere else
RDEPEND=">=x11-libs/gtk+-3.0.2:3
	>=x11-libs/cairo-1.10
	x11-libs/pango
	>=x11-themes/gnome-icon-theme-2.22.0
	>=app-text/enchant-1.1.7
	gnome-base/gsettings-desktop-schemas
	>=app-text/iso-codes-0.49
	>=net-libs/libsoup-2.26.0:2.4"
DEPEND="${RDEPEND}
	x11-proto/xproto
	sys-devel/gettext
	>=dev-util/intltool-0.40.0
	virtual/pkgconfig"

pkg_setup() {
	ELTCONF="--reverse-deps"
	G2CONF="${G2CONF}
		--disable-static"
	DOCS="AUTHORS BUGS ChangeLog NEWS README TODO"
}

src_prepare() {
	# Regenerate marshallers for <glib-2.31 compatibility
	rm -v components/editor/gtkhtml-spell-marshal.{c,h} \
		components/editor/gtkhtml-editor-marshal.{c,h} || die
	gnome2_src_prepare
}

src_install() {
	gnome2_src_install

	elog "The gtkhtml-editor-test utility is now called gtkhtml-editor-test-${SLOT}"
	# Don't collide with 3.14 slot
	mv "${ED}"/usr/bin/gtkhtml-editor-test{,-${SLOT}} || die
}
