# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gthumb/gthumb-2.14.4.ebuild,v 1.7 2012/12/05 22:18:46 tetromino Exp $

EAPI="5"
GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="Image viewer and browser for Gnome"
HOMEPAGE="https://live.gnome.org/gthumb"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE="cdr exif gnome-keyring gstreamer http jpeg raw tiff test"

# We can't link against libbrasero-burn3
RDEPEND=">=dev-libs/glib-2.28.0:2
	>=x11-libs/gtk+-2.24.0:2
	>=gnome-base/gconf-2.6
	>=dev-libs/libunique-1.1.2:1

	media-libs/libpng:0=
	sys-libs/zlib
	x11-libs/libSM

	cdr? ( >=app-cdr/brasero-2.28
		   <app-cdr/brasero-2.90 )
	exif? ( >=media-gfx/exiv2-0.18:= )
	gnome-keyring? ( >=gnome-base/gnome-keyring-2.28 )
	gstreamer? (
		media-libs/gstreamer:0.10
		media-libs/gst-plugins-base:0.10 )
	http? (
		>=net-libs/libsoup-2.26:2.4
		>=net-libs/libsoup-gnome-2.26:2.4 )
	jpeg? ( virtual/jpeg:0= )
	tiff? ( media-libs/tiff:= )
	raw? ( >=media-libs/libopenraw-0.0.8:= )
	!raw? ( media-gfx/dcraw )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	app-text/scrollkeeper
	>=dev-util/intltool-0.35
	app-text/gnome-doc-utils
	sys-devel/bison
	sys-devel/flex
	test? ( ~app-text/docbook-xml-dtd-4.1.2 )"
# eautoreconf needs:
#	gnome-base/gnome-common

pkg_setup() {
# Upstream says in configure help that libchamplain support crashes
# frequently
# Clutter disabled for bug #435164
	G2CONF="${G2CONF}
		--disable-static
		--disable-libchamplain
		--enable-unique
		--disable-gnome-3
		$(use_enable cdr libbrasero)
		$(use_enable exif exiv2)
		$(use_enable gstreamer)
		$(use_enable gnome-keyring)
		$(use_enable http libsoup)
		$(use_enable jpeg)
		$(use_enable raw libopenraw)
		--disable-clutter
		$(use_enable test test-suite)
		$(use_enable tiff)"
	DOCS="AUTHORS ChangeLog NEWS README"
}

src_prepare() {
	gnome2_src_prepare

	# Remove unwanted CFLAGS added with USE=debug
	sed -e 's/CFLAGS="$CFLAGS -g -O0 -DDEBUG"//' -i configure.ac -i configure || die

	# GSeal doesn't get disabled with --disable-gseal
	sed -e 's/-DGSEAL_ENABLE//g' -i configure.ac -i configure || die
}
