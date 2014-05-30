# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libgaminggear/libgaminggear-0.2.0.ebuild,v 1.1 2014/05/30 10:20:05 swift Exp $

EAPI=5

inherit cmake-utils gnome2-utils

DESCRIPTION="Provides functionality for gaming input devices"

HOMEPAGE="http://sourceforge.net/projects/libgaminggear/"
SRC_URI="mirror://sourceforge/libgaminggear/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	x11-libs/gtk+:2
	x11-libs/libnotify
	media-libs/libcanberra
	virtual/libusb:1
	dev-libs/dbus-glib
	virtual/udev[gudev]
"

DEPEND="${RDEPEND}
	app-doc/doxygen
"
src_configure() {
	mycmakeargs=( -DCMAKE_INSTALL_PREFIX=${EPREFIX}/usr )
	cmake-utils_src_configure
}
src_install() {
	cmake-utils_src_install
}
pkg_preinst() {
	gnome2_icon_savelist
}
pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
