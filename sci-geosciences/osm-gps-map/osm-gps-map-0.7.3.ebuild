# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/osm-gps-map/osm-gps-map-0.7.3.ebuild,v 1.1 2013/03/28 18:57:59 tomwij Exp $

EAPI="5"

inherit autotools gnome2

DESCRIPTION="A gtk+ viewer for OpenStreetMap files."
HOMEPAGE="http://nzjrs.github.com/${PN}/"
SRC_URI="http://www.johnstowers.co.nz/files/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="introspection python"

DEPEND="
	>=dev-libs/glib-2.16.0
	gnome-base/gnome-common
	>=net-libs/libsoup-2.4.0
	>=x11-libs/cairo-1.6.0
	>=x11-libs/gtk+-2.14.0
	introspection? ( dev-libs/gobject-introspection )
"
RDEPEND="${DEPEND}"

G2CONF="
	$(use_enable introspection)
	--docdir=/usr/share/doc/${PN}
	--disable-dependency-tracking
	--enable-fast-install
	--disable-static
"

src_prepare() {
	epatch "${FILESDIR}/${P}-fix-docs-location.patch"
#	epatch "${FILESDIR}/${P}-disable-compiler-warnings.patch"
	eautoreconf

	gnome2_src_prepare
}
