# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/at-spi2-atk/at-spi2-atk-2.8.1.ebuild,v 1.5 2013/12/08 17:31:30 pacho Exp $

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit eutils gnome2 virtualx

DESCRIPTION="Gtk module for bridging AT-SPI to Atk"
HOMEPAGE="http://live.gnome.org/Accessibility"

LICENSE="LGPL-2+"
SLOT="2"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~arm-linux ~x86-linux"
IUSE=""

COMMON_DEPEND="
	>=app-accessibility/at-spi2-core-2.7.5
	>=dev-libs/atk-2.7.90
	>=dev-libs/glib-2.32:2
	>=sys-apps/dbus-1
"
RDEPEND="${COMMON_DEPEND}
	!<gnome-extra/at-spi-1.32.0-r1
"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
"

src_configure() {
	gnome2_src_configure --enable-p2p
}

src_test() {
	Xemake check
}
