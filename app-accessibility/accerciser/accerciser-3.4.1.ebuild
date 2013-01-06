# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/accerciser/accerciser-3.4.1.ebuild,v 1.1 2012/05/20 08:41:00 tetromino Exp $

EAPI="4"
GCONF_DEBUG="no"
PYTHON_DEPEND="2:2.5"
PYTHON_USE_WITH="xml"

inherit gnome2 python

DESCRIPTION="Interactive Python accessibility explorer"
HOMEPAGE="http://live.gnome.org/Accerciser"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=app-accessibility/at-spi2-core-2.1.5:2
	>=dev-python/pygobject-2.90.3:3
	>=x11-libs/gtk+-3.1.13:3[introspection]

	dev-libs/atk[introspection]
	>=dev-libs/glib-2.28:2
	dev-libs/gobject-introspection
	>=dev-python/ipython-0.11
	>=dev-python/pyatspi-2.1.5
	dev-python/pycairo
	x11-libs/gdk-pixbuf[introspection]
	x11-libs/libwnck:3[introspection]
	x11-libs/pango[introspection]"
DEPEND="${RDEPEND}
	>=app-text/gnome-doc-utils-0.17.3
	app-text/scrollkeeper
	>=dev-util/intltool-0.35
	sys-devel/gettext
	virtual/pkgconfig"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README"
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	gnome2_src_prepare

	python_clean_py-compile_files
	python_convert_shebangs -r 2 .
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_need_rebuild
	python_mod_optimize "${PN}" /usr/share/${PN}
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup "${PN}" /usr/share/${PN}
}
