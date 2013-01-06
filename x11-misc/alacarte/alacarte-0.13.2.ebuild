# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/alacarte/alacarte-0.13.2.ebuild,v 1.12 2012/12/15 20:13:34 swegener Exp $

EAPI="3"
GCONF_DEBUG="no"
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 2.5 3.*"

inherit gnome2 python

DESCRIPTION="Simple GNOME menu editor"
HOMEPAGE="http://live.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

common_depends="
	>=dev-python/pygobject-2.15.1:2
	>=dev-python/pygtk-2.13:2
	>=gnome-base/gnome-menus-2.27.92:0[python]"

RDEPEND="${common_depends}
	>=gnome-base/gnome-panel-2.16"

DEPEND="${common_depends}
	sys-devel/gettext
	>=dev-util/intltool-0.40.0
	virtual/pkgconfig"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README"
	python_pkg_setup
}

src_prepare() {
	gnome2_src_prepare

	# disable pyc compiling
	mv py-compile py-compile.orig
	ln -s $(type -P true) py-compile

	python_copy_sources
}

src_configure() {
	configure() {
		G2CONF="${G2CONF} PYTHON=$(PYTHON -a)"
		gnome2_src_configure
	}
	python_execute_function -s configure
}

src_compile() {
	python_execute_function -s gnome2_src_compile
}

src_test() {
	python_execute_function -s -d
}

src_install() {
	python_execute_function -s gnome2_src_install
	python_clean_installation_image
	python_convert_shebangs -r 2 "${ED}"
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_mod_optimize Alacarte
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup Alacarte
}
