# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/libgxps/libgxps-0.2.2.ebuild,v 1.6 2013/01/01 14:04:39 ago Exp $

EAPI="4"
GNOME2_LA_PUNT="yes"
GCONF_DEBUG="yes"

inherit gnome2

DESCRIPTION="Library for handling and rendering XPS documents"
HOMEPAGE="http://live.gnome.org/libgxps"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug doc +introspection jpeg lcms static-libs tiff"

RDEPEND=">=app-arch/libarchive-2.8
	>=dev-libs/glib-2.24:2
	media-libs/freetype:2
	media-libs/libpng:0
	>=x11-libs/cairo-1.10[svg]
	introspection? ( >=dev-libs/gobject-introspection-0.10.1 )
	jpeg? ( virtual/jpeg )
	lcms? ( media-libs/lcms:2 )
	tiff? ( media-libs/tiff[zlib] )"
DEPEND="${RDEPEND}
	app-text/docbook-xsl-stylesheets
	dev-libs/libxslt
	virtual/pkgconfig
	doc? (
		app-text/docbook-xml-dtd:4.1.2
		>=dev-util/gtk-doc-1.14 )"

# eautoreconf requires: dev-util/gtk-doc-am

# There is no automatic test suite, only an interactive test application
RESTRICT="test"

pkg_setup() {
	G2CONF="${G2CONF}
		--enable-man
		--disable-test
		$(use_enable debug)
		$(use_enable introspection)
		$(use_with jpeg libjpeg)
		$(use_with lcms liblcms2)
		$(use_enable static-libs static)
		$(use_with tiff libtiff)"
	DOCS="AUTHORS ChangeLog NEWS README TODO"
}
