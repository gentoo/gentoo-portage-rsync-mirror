# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/d-feet/d-feet-0.1.12.ebuild,v 1.3 2012/01/09 10:27:57 nirbheek Exp $

EAPI="3"
PYTHON_DEPEND="2:2.6"
GCONF_DEBUG="no"

inherit gnome2 distutils

DESCRIPTION="D-Feet is a powerful D-Bus debugger"
HOMEPAGE="http://live.gnome.org/DFeet"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome"

RDEPEND=">=sys-apps/dbus-1.0
	>=dev-python/dbus-python-0.82.3
	dev-python/pygtk
	gnome? ( dev-python/libwnck-python )"

PYTHON_MODNAME="dfeet"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_configure() {
	# Don't call gnome2_src_configure().
	:
}

pkg_postinst() {
	distutils_pkg_postinst
	gnome2_icon_cache_update
}
