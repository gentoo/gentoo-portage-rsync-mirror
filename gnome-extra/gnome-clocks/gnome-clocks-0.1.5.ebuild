# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-clocks/gnome-clocks-0.1.5.ebuild,v 1.1 2012/12/27 07:11:25 tetromino Exp $

EAPI="5"
GCONF_DEBUG="no"
PYTHON_COMPAT=( python2_{6,7} )

inherit gnome2 distutils-r1

DESCRIPTION="Clocks applications for GNOME"
HOMEPAGE="http://live.gnome.org/GnomeClocks"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-libs/libgweather[introspection]
	dev-python/pycairo
	>=dev-python/pygobject-3.4.2:3[${PYTHON_USEDEP}]
	dev-python/pyxdg[${PYTHON_USEDEP}]
	media-libs/clutter-gtk:1.0[introspection]
	media-libs/clutter:1.0[introspection]
	media-libs/libcanberra
	x11-libs/gdk-pixbuf:2[introspection]
	x11-libs/gtk+:3[introspection]
	x11-libs/libnotify[introspection]
	x11-libs/pango[introspection]
"
DEPEND="${RDEPEND}
	dev-python/python-distutils-extra
"

src_prepare() {
	gnome2_environment_reset
	distutils-r1_python_prepare
}
