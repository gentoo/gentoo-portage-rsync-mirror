# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/rest/rest-0.7.12.ebuild,v 1.7 2012/09/23 06:00:48 blueness Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2 virtualx

DESCRIPTION="Helper library for RESTful services"
HOMEPAGE="http://git.gnome.org/browse/librest"

LICENSE="LGPL-2.1"
SLOT="0.7"
KEYWORDS="~alpha amd64 ~ppc ~ppc64 x86"
IUSE="doc +gnome +introspection test"

# Coverage testing should not be enabled
RDEPEND="app-misc/ca-certificates
	>=dev-libs/glib-2.22:2
	dev-libs/libxml2:2
	net-libs/libsoup:2.4
	gnome? ( >=net-libs/libsoup-gnome-2.25.1:2.4 )
	introspection? ( >=dev-libs/gobject-introspection-0.6.7 )"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40
	virtual/pkgconfig
	doc? ( >=dev-util/gtk-doc-1.13 )
	test? ( sys-apps/dbus )"

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-static
		--disable-gcov
		--with-ca-certificates=${EPREFIX}/etc/ssl/certs/ca-certificates.crt
		$(use_with gnome)
		$(use_enable introspection)"
	DOCS="AUTHORS README"
}

src_test() {
	# Tests need dbus
	Xemake check || die
}
