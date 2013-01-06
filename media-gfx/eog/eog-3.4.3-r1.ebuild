# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/eog/eog-3.4.3-r1.ebuild,v 1.1 2012/10/11 14:08:29 tetromino Exp $

EAPI="4"
GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"

inherit autotools eutils gnome2

DESCRIPTION="The Eye of GNOME image viewer"
HOMEPAGE="http://www.gnome.org/projects/eog/"

LICENSE="GPL-2+"
SLOT="1"
IUSE="doc +exif +introspection +jpeg lcms +svg tiff xmp"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"

RDEPEND=">=x11-libs/gtk+-3.3.6:3[introspection,X]
	>=dev-libs/glib-2.31.0:2
	>=dev-libs/libxml2-2:2
	>=dev-libs/libpeas-0.7.4[gtk]
	>=gnome-base/gnome-desktop-2.91.2:3
	>=gnome-base/gsettings-desktop-schemas-2.91.92
	>=x11-themes/gnome-icon-theme-2.19.1
	>=x11-misc/shared-mime-info-0.20

	x11-libs/gdk-pixbuf:2[jpeg?,tiff?]
	x11-libs/libX11

	exif? (
		>=media-libs/libexif-0.6.14
		virtual/jpeg:0 )
	introspection? ( >=dev-libs/gobject-introspection-0.9.3 )
	jpeg? ( virtual/jpeg:0 )
	lcms? ( media-libs/lcms:2 )
	svg? ( >=gnome-base/librsvg-2.36.2:2 )
	xmp? ( media-libs/exempi:2 )"

DEPEND="${RDEPEND}
	app-text/gnome-doc-utils
	dev-util/gtk-doc-am
	>=dev-util/intltool-0.40
	sys-devel/gettext
	virtual/pkgconfig
	dev-libs/gobject-introspection-common"
# eautoreconf requires dev-libs/gobject-introspection-common

pkg_setup() {
	G2CONF="${G2CONF}
		$(use_enable introspection)
		$(use_with jpeg libjpeg)
		$(use_with exif libexif)
		$(use_with lcms cms)
		$(use_with xmp)
		$(use_with svg librsvg)
		--disable-scrollkeeper
		--disable-schemas-compile"
	DOCS="AUTHORS ChangeLog HACKING MAINTAINERS NEWS README THANKS TODO"
}

src_prepare() {
	# Fix USE=-svg build problems, bug #437880
	epatch "${FILESDIR}/${P}-require-librsvg-2.36.2.patch"
	epatch "${FILESDIR}/${P}-libm.patch"
	# https://bugzilla.gnome.org/show_bug.cgi?id=685923
	epatch "${FILESDIR}/${PN}-3.6.0-eog.desktop.patch"
	eautoreconf
	gnome2_src_prepare
}
