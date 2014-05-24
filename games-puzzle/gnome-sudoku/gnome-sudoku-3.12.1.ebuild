# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/gnome-sudoku/gnome-sudoku-3.12.1.ebuild,v 1.2 2014/05/24 10:19:38 pacho Exp $

EAPI="5"
GCONF_DEBUG="no"
PYTHON_COMPAT=( python{3_2,3_3} )

inherit eutils gnome-games python-single-r1

DESCRIPTION="Test your logic skills in this number grid puzzle"
HOMEPAGE="https://wiki.gnome.org/GnomeSudoku"

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""
# Let people emerge this by default, bug #472932
IUSE+=" python_single_target_python3_2 +python_single_target_python3_3"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	dev-libs/glib:2
	dev-python/pycairo[${PYTHON_USEDEP}]
	>=dev-python/pygobject-3.11:3[${PYTHON_USEDEP}]
	x11-libs/gdk-pixbuf:2[introspection]
	x11-libs/gtk+:3[introspection]
	x11-libs/pango[introspection]
"
DEPEND="${RDEPEND}
	app-text/yelp-tools
	>=dev-util/intltool-0.50
	sys-devel/gettext
	virtual/pkgconfig
"

pkg_setup() {
	gnome-games_pkg_setup
	python-single-r1_pkg_setup
}

src_configure() {
	# Workaround until we know how to fix bug #475318
	gnome-games_src_configure \
		--prefix="${EPREFIX}/usr" \
		--bindir="${GAMES_BINDIR}"
}

src_install() {
	python_fix_shebang src
	gnome-games_src_install
}
