# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gthumb/gthumb-3.0.2.ebuild,v 1.2 2012/12/05 22:18:46 tetromino Exp $

EAPI="5"
GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="Image viewer and browser for Gnome"
HOMEPAGE="https://live.gnome.org/gthumb"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="cdr exif gnome-keyring gstreamer http jpeg raw slideshow svg tiff test"

COMMON_DEPEND="
	>=dev-libs/glib-2.28:2
	>=x11-libs/gtk+-3.2:3

	media-libs/libpng:0=
	sys-libs/zlib
	x11-libs/libICE
	x11-libs/libSM

	cdr? ( >=app-cdr/brasero-3.2 )
	exif? ( >=media-gfx/exiv2-0.21:= )
	gnome-keyring? ( >=gnome-base/gnome-keyring-3.2 )
	gstreamer? (
		>=media-libs/gstreamer-0.10:0.10
		>=media-libs/gst-plugins-base-0.10:0.10 )
	http? (
		>=net-libs/libsoup-2.36:2.4
		>=net-libs/libsoup-gnome-2.36:2.4 )
	jpeg? ( virtual/jpeg:0= )
	slideshow? (
		>=media-libs/clutter-1:1.0
		>=media-libs/clutter-gtk-1:1.0 )
	svg? ( >=gnome-base/librsvg-2.34 )
	tiff? ( media-libs/tiff:= )
	raw? ( >=media-libs/libopenraw-0.0.8:= )
	!raw? ( media-gfx/dcraw )"
RDEPEND="${COMMON_DEPEND}
	>=gnome-base/gsettings-desktop-schemas-0.1.4"
DEPEND="${COMMON_DEPEND}
	app-text/gnome-doc-utils
	app-text/scrollkeeper
	>=dev-util/intltool-0.35
	sys-devel/bison
	sys-devel/flex
	virtual/pkgconfig
	test? ( ~app-text/docbook-xml-dtd-4.1.2 )"
# eautoreconf needs:
#	gnome-base/gnome-common

src_prepare() {
	# Upstream says in configure help that libchamplain support
	# crashes frequently
	G2CONF="${G2CONF}
		--disable-static
		--disable-libchamplain
		--with-smclient=xsmp
		$(use_enable cdr libbrasero)
		$(use_enable exif exiv2)
		$(use_enable gstreamer)
		$(use_enable gnome-keyring)
		$(use_enable http libsoup)
		$(use_enable jpeg)
		$(use_enable raw libopenraw)
		$(use_enable slideshow clutter)
		$(use_enable svg librsvg)
		$(use_enable test test-suite)
		$(use_enable tiff)"
	DOCS="AUTHORS ChangeLog NEWS README"

	# Remove unwanted CFLAGS added with USE=debug
	sed -e 's/CFLAGS="$CFLAGS -g -O0 -DDEBUG"//' \
		-i configure.ac -i configure || die

	gnome2_src_prepare
}
