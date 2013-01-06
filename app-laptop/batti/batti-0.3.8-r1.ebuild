# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/batti/batti-0.3.8-r1.ebuild,v 1.4 2011/12/04 10:16:25 hwoarang Exp $

EAPI=3

SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2"
RESTRICT_PYTHON_ABIS="3.*"

inherit python distutils gnome2-utils

DESCRIPTION="A upower based battery monitor for the system tray, similar to batterymon"
HOMEPAGE="http://code.google.com/p/batti-gtk/"
SRC_URI="http://batti-gtk.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="libnotify"

RDEPEND="dev-python/pygtk
	dev-python/dbus-python
	sys-power/upower
	x11-themes/hicolor-icon-theme
	libnotify? ( x11-libs/libnotify )
	virtual/freedesktop-icon-theme"
DEPEND=""

DOCS="AUTHORS"

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
	distutils_pkg_postinst
}

pkg_postrm() {
	gnome2_icon_cache_update
	distutils_pkg_postrm
}
