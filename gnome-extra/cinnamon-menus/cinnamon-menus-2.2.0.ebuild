# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/cinnamon-menus/cinnamon-menus-2.2.0.ebuild,v 1.3 2014/07/23 15:17:41 ago Exp $

EAPI="5"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="Cinnamon's library for the Desktop Menu fd.o specification"
HOMEPAGE="http://cinnamon.linuxmint.com/"
SRC_URI="https://github.com/linuxmint/cinnamon-menus/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+ LGPL-2+"
SLOT="0"
KEYWORDS="amd64 x86"

IUSE="debug +introspection"

RDEPEND="
	>=dev-libs/glib-2.29.15:2
	introspection? ( >=dev-libs/gobject-introspection-0.9.5 )
"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40
	sys-devel/gettext
	virtual/pkgconfig
"

src_configure() {
	DOCS="AUTHORS ChangeLog HACKING NEWS README"

	# Do NOT compile with --disable-debug/--enable-debug=no
	# It disables api usage checks
	gnome2_src_configure \
		$(usex debug --enable-debug=yes --enable-debug=minimum) \
		$(use_enable introspection) \
		--disable-static
}
