# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gtkhtml/gtkhtml-3.32.2.ebuild,v 1.9 2012/12/17 11:58:19 tetromino Exp $

EAPI="3"
GCONF_DEBUG="no"

inherit eutils gnome2

DESCRIPTION="Lightweight HTML rendering/printing/editing engine"
HOMEPAGE="http://projects.gnome.org/evolution/"

LICENSE="GPL-2+ LGPL-2+"
SLOT="3.14"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 sh sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux"
IUSE=""

RDEPEND="
	>=dev-libs/glib-2.24:2
	>=x11-libs/gtk+-2.20:2
	>=x11-themes/gnome-icon-theme-2.22.0
	>=gnome-base/orbit-2
	>=app-text/enchant-1.1.7
	gnome-base/gconf:2
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
		--disable-static
		--disable-deprecated-warning-flags"
	DOCS="AUTHORS BUGS ChangeLog NEWS README TODO"
}

src_prepare() {
	# Fix build with recent glib, bug #436462
	epatch "${FILESDIR}/${P}-g_thread_init.patch"
	gnome2_src_prepare
}

src_install() {
	gnome2_src_install
	# Remove .la files since old will be removed anyway while updating
	find "${ED}" -name "*.la" -delete || die "remove of la files failed"
}

pkg_preinst() {
	gnome2_pkg_preinst
	preserve_old_lib /usr/$(get_libdir)/libgtkhtml-editor.so.0
}

pkg_postinst() {
	gnome2_pkg_postinst
	preserve_old_lib_notify /usr/$(get_libdir)/libgtkhtml-editor.so.0
}
