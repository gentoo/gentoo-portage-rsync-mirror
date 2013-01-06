# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/accerciser/accerciser-1.12.1.ebuild,v 1.8 2012/02/10 04:04:50 patrick Exp $

EAPI="3"
GCONF_DEBUG="no"
PYTHON_DEPEND="2:2.5"

inherit gnome2 python

DESCRIPTION="Interactive Python accessibility explorer"
HOMEPAGE="http://live.gnome.org/Accerciser"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="dev-python/ipython
	dev-python/pygtk:2
	dev-python/pygobject:2
	dev-python/pycairo
	dev-python/libgnome-python
	dev-python/libwnck-python
	dev-python/pygtksourceview
	dev-python/gconf-python
	dev-python/librsvg-python
	>=gnome-extra/at-spi-1.7:1
	dev-libs/glib:2"
DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/intltool-0.35
	app-text/scrollkeeper
	>=app-text/gnome-doc-utils-0.12"

pkg_setup() {
	G2CONF="${G2CONF} --without-pyreqs"
	DOCS="AUTHORS COPYING ChangeLog NEWS README"
	python_set_active_version 2
}

src_prepare() {
	gnome2_src_prepare

	# disable pyc compiling
	echo '#!/bin/sh' > py-compile

	python_convert_shebangs -r 2 .
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_need_rebuild
	python_mod_optimize "${PN}"
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup "${PN}"
}
