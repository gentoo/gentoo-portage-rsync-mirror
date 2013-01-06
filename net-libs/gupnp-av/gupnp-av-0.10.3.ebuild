# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gupnp-av/gupnp-av-0.10.3.ebuild,v 1.7 2013/01/06 09:59:44 ago Exp $

EAPI="4"

inherit gnome.org

DESCRIPTION="A small utility library that aims to ease the handling UPnP A/V profiles"
HOMEPAGE="http://gupnp.org/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ~ppc64 ~sparc x86"
IUSE="+introspection"

RDEPEND=">=dev-libs/glib-2.16:2
	>=net-libs/gssdp-0.9.2[introspection?]
	>=net-libs/libsoup-2.28.2:2.4[introspection?]
	>=net-libs/gupnp-0.17[introspection?]
	introspection? ( >=dev-libs/gobject-introspection-0.9.5 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README"

src_configure() {
	econf \
		$(use_enable introspection) \
		--disable-dependency-tracking \
		--disable-static \
		--disable-gtk-doc
}

src_install() {
	default
	# Remove pointless .la files
	find "${D}" -name '*.la' -delete
}
