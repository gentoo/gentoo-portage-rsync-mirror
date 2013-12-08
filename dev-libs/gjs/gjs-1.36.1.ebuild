# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gjs/gjs-1.36.1.ebuild,v 1.4 2013/12/08 17:57:02 pacho Exp $

EAPI="5"
GCONF_DEBUG="no"

inherit gnome2 pax-utils virtualx

DESCRIPTION="Javascript bindings for GNOME"
HOMEPAGE="http://live.gnome.org/Gjs"

LICENSE="MIT || ( MPL-1.1 LGPL-2+ GPL-2+ )"
SLOT="0"
IUSE="+cairo examples"
KEYWORDS="~alpha amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc x86 ~amd64-fbsd"

RDEPEND="
	>=dev-libs/glib-2.36.0:2
	>=dev-libs/gobject-introspection-1.36.0

	dev-libs/dbus-glib
	sys-libs/readline
	>=dev-lang/spidermonkey-1.8.5:0
	virtual/libffi
	cairo? ( x11-libs/cairo )
"
DEPEND="${RDEPEND}
	sys-devel/gettext
	virtual/pkgconfig
"

src_configure() {
	# AUTHORS, ChangeLog are empty
	DOCS="NEWS README"

	# FIXME: add systemtap/dtrace support, like in glib:2
	# FIXME: --enable-systemtap installs files in ${D}/${D} for some reason
	# XXX: Do NOT enable coverage, completely useless for portage installs
	gnome2_src_configure \
		--disable-systemtap \
		--disable-dtrace \
		--disable-coverage \
		$(use_with cairo cairo)
}

src_test() {
	# Tests need dbus
	Xemake check
}

src_install() {
	# installation sometimes fails in parallel
	gnome2_src_install -j1

	if use examples; then
		insinto /usr/share/doc/"${PF}"/examples
		doins "${S}"/examples/*
	fi

	# Required for gjs-console to run correctly on PaX systems
	pax-mark mr "${ED}/usr/bin/gjs-console"
}
