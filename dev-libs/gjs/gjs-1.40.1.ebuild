# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gjs/gjs-1.40.1.ebuild,v 1.9 2014/09/15 08:18:18 ago Exp $

EAPI="5"
GCONF_DEBUG="no"

inherit gnome2 pax-utils virtualx

DESCRIPTION="Javascript bindings for GNOME"
HOMEPAGE="http://live.gnome.org/Gjs"

LICENSE="MIT || ( MPL-1.1 LGPL-2+ GPL-2+ )"
SLOT="0"
IUSE="+cairo examples gtk test"
KEYWORDS="alpha amd64 ~arm ia64 ppc ppc64 sparc x86"

RDEPEND="
	>=dev-libs/glib-2.36:2
	>=dev-libs/gobject-introspection-1.39.3

	sys-libs/readline:0
	dev-lang/spidermonkey:24
	virtual/libffi
	cairo? ( x11-libs/cairo )
	gtk? ( x11-libs/gtk+:3 )
"
DEPEND="${RDEPEND}
	gnome-base/gnome-common
	sys-devel/gettext
	virtual/pkgconfig
	test? ( sys-apps/dbus )
"

# Large amount of tests are broken even in master.
RESTRICT="test"

src_configure() {
	# FIXME: add systemtap/dtrace support, like in glib:2
	# FIXME: --enable-systemtap installs files in ${D}/${D} for some reason
	# XXX: Do NOT enable coverage, completely useless for portage installs
	gnome2_src_configure \
		--disable-systemtap \
		--disable-dtrace \
		--disable-coverage \
		$(use_with cairo cairo) \
		$(use_with gtk)
}

src_test() {
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
