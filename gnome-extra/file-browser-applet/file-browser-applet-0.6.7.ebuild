# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/file-browser-applet/file-browser-applet-0.6.7.ebuild,v 1.4 2012/05/05 06:25:17 jdhore Exp $

EAPI="2"

inherit gnome2 cmake-utils

DESCRIPTION="Browse, open and manage files in your computer directly from the GNOME panel."
HOMEPAGE="http://code.google.com/p/gnome-menu-file-browser-applet/"
SRC_URI="http://gnome-menu-file-browser-applet.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="gtkhotkey"

RDEPEND=">=x11-libs/gtk+-2.14:2
	|| ( gnome-base/gnome-panel[bonobo] <gnome-base/gnome-panel-2.32 )
	>=dev-libs/glib-2.16
	gtkhotkey? ( x11-libs/gtkhotkey )"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=dev-util/cmake-2.4.8"

src_prepare() {
	sed -i -e "s/-O3 -g//g" CMakeLists.txt
}

src_compile() {
	mycmakeargs="${mycmakeargs} -DCMAKE_INSTALL_GCONF_SCHEMA_DIR=/etc/gconf/schemas"
	mycmakeargs="${mycmakeargs} $(cmake-utils_use_enable gtkhotkey GTK_HOTKEY)"
	cmake-utils_src_compile
}

src_install() {
	export GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1"
	cmake-utils_src_install
	unset GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL
	dodoc HISTORY README || die "dodoc failed"
}
