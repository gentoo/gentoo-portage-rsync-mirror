# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/orca/orca-3.4.2.ebuild,v 1.2 2012/12/16 07:53:08 tetromino Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
PYTHON_DEPEND="2:2.7"
PYTHON_USE_WITH="threads"
# FIXME: multiple python support

inherit gnome2 python

DESCRIPTION="Extensible screen reader that provides access to the desktop"
HOMEPAGE="http://projects.gnome.org/orca/"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE=""

# liblouis is not in portage yet
# it is used to provide contracted braille support
# XXX: Check deps for correctness
COMMON_DEPEND=">=app-accessibility/at-spi2-core-2.3.5:2
	>=dev-libs/glib-2.28:2
	>=dev-python/pygobject-3.0.2:3
	>=x11-libs/gtk+-3.1.13:3[introspection]"
RDEPEND="${COMMON_DEPEND}
	app-accessibility/speech-dispatcher[python]
	dev-libs/atk[introspection]
	>=dev-python/dbus-python-0.83
	dev-python/pyatspi
	dev-python/pycairo
	dev-python/pyxdg
	dev-python/setproctitle
	x11-libs/libwnck:3[introspection]
	x11-libs/pango[introspection]"
DEPEND="${COMMON_DEPEND}
	>=app-text/gnome-doc-utils-0.17.3
	>=dev-util/intltool-0.40
	virtual/pkgconfig"

pkg_setup() {
	DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README TODO"
	python_set_active_version 2
	python_pkg_setup
	G2CONF="${G2CONF} PYTHON=$(PYTHON -2 -a)"
}

src_prepare() {
	gnome2_src_prepare

	python_clean_py-compile_files

	# Workaround missing file in po files
	# echo "src/orca/scripts/toolkits/WebKitGtk/script.py" >> "${S}"/po/POTFILES.in
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_mod_optimize "${PN}"
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup "${PN}"
}
