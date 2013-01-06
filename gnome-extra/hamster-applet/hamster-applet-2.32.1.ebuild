# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/hamster-applet/hamster-applet-2.32.1.ebuild,v 1.9 2012/08/29 05:03:09 leio Exp $

EAPI="3"
GCONF_DEBUG="no"
PYTHON_DEPEND="2:2.5"
PYTHON_USE_WITH="sqlite"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit gnome2 multilib python waf-utils

DESCRIPTION="Time tracking for the masses, in a GNOME applet"
HOMEPAGE="http://projecthamster.wordpress.com/"

# license on homepage is out-of-date, was changed to GPL-2 on 2008-04-16
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE="eds libnotify"

RDEPEND="dev-python/gconf-python
	dev-python/libgnome-python
	dev-python/libwnck-python
	dev-python/gnome-applets-python
	dev-python/gnome-desktop-python
	dev-python/dbus-python
	dev-python/pyxdg
	>=dev-python/pygobject-2.14:2
	>=dev-python/pygtk-2.12:2
	gnome-base/gnome-control-center
	>=x11-libs/gtk+-2.12:2
	x11-libs/libXScrnSaver

	eds? ( dev-python/evolution-python )
	libnotify? ( dev-python/notify-python )
"
DEPEND="${RDEPEND}
	x11-proto/scrnsaverproto
	>=dev-util/intltool-0.40
	virtual/pkgconfig
	sys-devel/gettext
	>=app-text/gnome-doc-utils-0.17.3"

pkg_setup() {
	DOCS="AUTHORS NEWS README"
	python_pkg_setup
}

src_prepare() {
	gnome2_src_prepare
	python_copy_sources
}

src_configure() {
	python_execute_function -s waf-utils_src_configure
}

src_compile() {
	python_execute_function -s waf-utils_src_compile
}

src_install() {
	python_execute_function -s waf-utils_src_install
	python_convert_shebangs 2 "${ED}"usr/bin/*
	python_convert_shebangs 2 "${ED}"usr/$(get_libdir)/${PN}/${PN}
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_mod_optimize hamster
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup hamster
}
