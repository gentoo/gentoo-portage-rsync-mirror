# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/cjs/cjs-2.2.2.ebuild,v 1.2 2014/12/18 14:56:57 pacho Exp $

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
PYTHON_COMPAT=( python{2_6,2_7} )

inherit autotools gnome2 pax-utils python-any-r1 virtualx

DESCRIPTION="Linux Mint's fork of gjs for Cinnamon"
HOMEPAGE="http://cinnamon.linuxmint.com/"
SRC_URI="https://github.com/linuxmint/cjs/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT || ( MPL-1.1 LGPL-2+ GPL-2+ )"
SLOT="0"
IUSE="examples test"
KEYWORDS="~amd64 x86"

RDEPEND="
	>=dev-lang/spidermonkey-1.8.5:0
	dev-libs/dbus-glib
	>=dev-libs/glib-2.32:2
	>=dev-libs/gobject-introspection-1.32
	sys-libs/ncurses
	sys-libs/readline:0
	x11-libs/cairo[glib]
	virtual/libffi
"
DEPEND="${RDEPEND}
	${PYTHON_DEPS}
	sys-devel/gettext
	virtual/pkgconfig
	test? ( sys-apps/dbus )
"

# Large amount of tests are broken even in master.
RESTRICT="test"

src_prepare() {
	epatch_user
	eautoreconf
	gnome2_src_prepare
}

src_configure() {
	# FIXME: add systemtap/dtrace support, like in glib:2
	# FIXME: --enable-systemtap installs files in ${D}/${D} for some reason
	# XXX: Do NOT enable coverage, completely useless for portage installs
	gnome2_src_configure \
		--disable-systemtap \
		--disable-dtrace \
		--disable-coverage
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

	# Required for cjs-console to run correctly on PaX systems
	pax-mark mr "${ED}/usr/bin/cjs-console"
}
