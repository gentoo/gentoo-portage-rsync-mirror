# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gjs/gjs-1.34.0-r1.ebuild,v 1.1 2013/10/03 03:54:17 tetromino Exp $

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
PYTHON_COMPAT=( python{2_6,2_7} )

inherit gnome2 pax-utils python-any-r1 virtualx

DESCRIPTION="Javascript bindings for GNOME"
HOMEPAGE="http://live.gnome.org/Gjs"

LICENSE="MIT || ( MPL-1.1 LGPL-2+ GPL-2+ )"
SLOT="0"
IUSE="examples test"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd"

RDEPEND=">=dev-libs/glib-2.32:2
	>=dev-libs/gobject-introspection-1.33.10

	dev-libs/dbus-glib
	sys-libs/readline
	x11-libs/cairo
	>=dev-lang/spidermonkey-1.8.5:0
	virtual/libffi
"
DEPEND="${RDEPEND}
	${PYTHON_DEPS}
	sys-devel/gettext
	virtual/pkgconfig
"

pkg_setup() {
	python-any-r1_pkg_setup
}

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
		$(use_enable test tests)
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
