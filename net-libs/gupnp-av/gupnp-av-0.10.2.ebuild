# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gupnp-av/gupnp-av-0.10.2.ebuild,v 1.1 2012/07/22 21:08:01 eva Exp $

EAPI="4"

inherit gnome.org

DESCRIPTION="A small utility library that aims to ease the handling UPnP A/V profiles"
HOMEPAGE="http://gupnp.org/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
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
		--disable-gtk-doc \
		--disable-gtk-doc-html \
		--disable-gtk-doc-pdf
}

src_install() {
	default
	# Remove pointless .la files
	find "${D}" -name '*.la' -delete
}
