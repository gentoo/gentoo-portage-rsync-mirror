# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/at-spi2-core/at-spi2-core-2.6.2-r1.ebuild,v 1.2 2012/12/18 17:56:55 ago Exp $

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit eutils gnome2

DESCRIPTION="D-Bus accessibility specifications and registration daemon"
HOMEPAGE="http://live.gnome.org/Accessibility"

LICENSE="LGPL-2+"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~x86 ~amd64-fbsd"
IUSE="+introspection"

RDEPEND=">=dev-libs/glib-2.28:2
	>=sys-apps/dbus-1
	x11-libs/libX11
	x11-libs/libXi
	x11-libs/libXtst
	introspection? ( >=dev-libs/gobject-introspection-0.9.6 )
"
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.9
	>=dev-util/intltool-0.40
	virtual/pkgconfig
"

src_prepare() {
	DOCS="AUTHORS ChangeLog NEWS README"
	# xevie is deprecated/broken since xorg-1.6/1.7
	G2CONF="${G2CONF} --disable-xevie"

	# disable teamspaces test since that requires Novell.ICEDesktop.Daemon
	epatch "${FILESDIR}/${PN}-2.0.2-disable-teamspaces-test.patch"

	# important patches from 2.6.3
	epatch "${FILESDIR}/${P}-hung-crash-"{1,2}.patch
	epatch "${FILESDIR}/${P}-deregister.patch"

	gnome2_src_prepare
}
