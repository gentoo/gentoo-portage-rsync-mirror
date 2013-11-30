# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/eiciel/eiciel-0.9.8.1.ebuild,v 1.5 2013/11/30 19:15:56 pacho Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="ACL editor for GNOME, with Nautilus extension"
HOMEPAGE="http://rofi.roger-ferrer.org/eiciel/"
SRC_URI="http://rofi.roger-ferrer.org/eiciel/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="xattr"

RDEPEND=">=sys-apps/acl-2.2.32
	>=dev-cpp/gtkmm-3:3.0
	>=gnome-base/nautilus-3"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=sys-devel/gettext-0.15"

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-static
		--with-gnome-version=3
		$(use_enable xattr user-attributes)"
	DOCS="AUTHORS README"
}
