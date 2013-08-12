# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/gnome-sudoku/gnome-sudoku-3.8.1.ebuild,v 1.2 2013/08/12 21:12:08 eva Exp $

EAPI="5"
GCONF_DEBUG="no"
PYTHON_COMPAT=( python{2_6,2_7} )

inherit eutils gnome-games python-single-r1

DESCRIPTION="Test your logic skills in this number grid puzzle"
HOMEPAGE="https://wiki.gnome.org/GnomeSudoku"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	dev-libs/glib:2
	dev-python/pycairo[${PYTHON_USEDEP}]
	>=dev-python/pygobject-2.28.3:3[${PYTHON_USEDEP}]
	x11-libs/gdk-pixbuf:2[introspection]
	x11-libs/gtk+:3[introspection]
	x11-libs/pango[introspection]
"
DEPEND="${RDEPEND}
	app-text/yelp-tools
	>=dev-util/intltool-0.35.0
	sys-devel/gettext
	virtual/pkgconfig
"

pkg_setup() {
	gnome-games_pkg_setup
	python-single-r1_pkg_setup
}

src_prepare() {
	# Fix NumberBox events configuration with latest pygobject (from 'master')
	epatch "${FILESDIR}/${PN}-3.8.1-fix-numberbox.patch"
	gnome-games_src_prepare
}

src_configure() {
	# Workaround until we know how to fix bug #475318
	gnome-games_src_configure \
		--prefix="${EPREFIX}/usr" \
		--bindir="${GAMES_BINDIR}"
}
