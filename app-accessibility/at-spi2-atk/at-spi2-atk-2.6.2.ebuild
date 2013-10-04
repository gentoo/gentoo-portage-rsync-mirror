# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/at-spi2-atk/at-spi2-atk-2.6.2.ebuild,v 1.10 2013/10/04 01:03:00 tetromino Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit eutils gnome2 virtualx

DESCRIPTION="Gtk module for bridging AT-SPI to Atk"
HOMEPAGE="http://live.gnome.org/Accessibility"

LICENSE="LGPL-2+"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~arm-linux ~x86-linux"
IUSE=""

COMMON_DEPEND="
	>=app-accessibility/at-spi2-core-2.6
	>=dev-libs/atk-2.1.0
	dev-libs/glib:2
	>=sys-apps/dbus-1
"
RDEPEND="${COMMON_DEPEND}"
#	!<gnome-extra/at-spi-1.32.0-r1
#"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
"

src_prepare() {
	DOCS="AUTHORS NEWS README"
	# xevie is deprecated/broken since xorg-1.6/1.7
	G2CONF="${G2CONF} --enable-p2p"

	# disable teamspaces test since that requires Novell.ICEDesktop.Daemon
	epatch "${FILESDIR}/${PN}-2.0.2-disable-teamspaces-test.patch"

	gnome2_src_prepare
}

src_test() {
	Xemake check
}
