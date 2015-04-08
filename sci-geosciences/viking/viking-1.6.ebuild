# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/viking/viking-1.6.ebuild,v 1.1 2015/04/06 07:10:23 graaff Exp $

EAPI=5

inherit eutils

DESCRIPTION="GPS data editor and analyzer"
HOMEPAGE="http://viking.sourceforge.net/"
IUSE="doc +exif gps +magic mapnik nls sqlite3"
SRC_URI="
	mirror://sourceforge/${PN}/${P}.tar.bz2
	doc? ( mirror://sourceforge/${PN}/${PN}.pdf )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

COMMONDEPEND="
	app-arch/bzip2
	dev-libs/expat
	dev-libs/glib:2
	net-misc/curl
	sys-libs/zlib
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:2
	gps? ( >=sci-geosciences/gpsd-2.96 )
	exif? ( media-libs/libexif )
	magic? ( sys-apps/file )
	mapnik? ( sci-geosciences/mapnik )
	sqlite3? ( dev-db/sqlite:3 )
"
RDEPEND="${COMMONDEPEND}
	sci-geosciences/gpsbabel
"
DEPEND="${COMMONDEPEND}
	app-text/gnome-doc-utils
	dev-util/intltool
	dev-util/gtk-doc-am
	app-text/rarian
	dev-libs/libxslt
	virtual/pkgconfig
	sys-devel/gettext
"

src_configure() {
	econf \
		--disable-deprecations \
		--with-libcurl \
		--with-expat \
		--enable-google \
		--enable-terraserver \
		--enable-expedia \
		--enable-openstreetmap \
		--enable-bluemarble \
		--enable-geonames \
		--enable-geocaches \
		--disable-dem24k \
		$(use_enable exif geotag) \
		$(use_enable gps realtime-gps-tracking) \
		$(use_enable magic) \
		$(use_enable mapnik) \
		$(use_enable nls) \
		$(use_enable sqlite3 mbtiles )
}

src_install() {
	default
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins "${DISTDIR}"/${PN}.pdf
	fi
}
