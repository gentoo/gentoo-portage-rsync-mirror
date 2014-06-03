# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/cinnamon-bluetooth/cinnamon-bluetooth-3.8.4.ebuild,v 1.2 2014/06/03 03:13:36 tetromino Exp $

EAPI="5"
GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"

inherit autotools eutils gnome2

DESCRIPTION="Bluetooth support libraries for Cinnamon"
HOMEPAGE="http://cinnamon.linuxmint.com/"
SRC_URI="https://github.com/linuxmint/cinnamon-bluetooth/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

# fails with gnome-bluetooth-3.12, https://github.com/linuxmint/cinnamon-bluetooth/issues/9
COMMON_DEPEND="
	>=dev-libs/glib-2.31:2
	gnome-extra/cinnamon-control-center
	>=net-wireless/gnome-bluetooth-3.4.1:2=
	<net-wireless/gnome-bluetooth-3.11
	>=x11-libs/gtk+-3.4.2:3
	x11-libs/libX11
"
RDEPEND="${COMMON_DEPEND}
	x11-themes/gnome-icon-theme-symbolic
"
DEPEND="${COMMON_DEPEND}
	>=dev-util/gtk-doc-am-1.9
	>=dev-util/intltool-0.40.1
	virtual/pkgconfig
	x11-proto/xproto
"
# eautoreconf needs:
#	gnome-base/gnome-common

src_prepare() {
	epatch_user
	eautoreconf
	gnome2_src_prepare
}
