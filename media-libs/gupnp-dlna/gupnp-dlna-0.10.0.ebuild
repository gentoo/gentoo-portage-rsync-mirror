# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gupnp-dlna/gupnp-dlna-0.10.0.ebuild,v 1.1 2013/03/28 17:42:14 pacho Exp $

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
VALA_MIN_API_VERSION="0.18"
VALA_USE_DEPEND="vapigen"

inherit gnome2 vala

DESCRIPTION="Library that provides DLNA-related functionality for MediaServers"
HOMEPAGE="http://gupnp.org/"

LICENSE="LGPL-2"
SLOT="0/3"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="+introspection"

RDEPEND=">=dev-libs/glib-2.32:2
	>=dev-libs/libxml2-2.5:2
	media-libs/gstreamer:1.0
	media-libs/gst-plugins-base:1.0[introspection?]
	introspection? ( >=dev-libs/gobject-introspection-0.6.4 )"
DEPEND="${RDEPEND}
	dev-util/gtk-doc-am
	virtual/pkgconfig
	$(vala_depend)"

src_prepare() {
	G2CONF="${G2CONF}
		--disable-static
		$(use_enable introspection)"
	DOCS="AUTHORS ChangeLog NEWS README TODO"

	gnome2_src_prepare
	vala_src_prepare
}

src_install() {
	MAKEOPTS="${MAKEOPTS} -j1" gnome2_src_install
}
