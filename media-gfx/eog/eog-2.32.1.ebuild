# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/eog/eog-2.32.1.ebuild,v 1.14 2012/10/27 08:33:28 tetromino Exp $

EAPI="3"
GCONF_DEBUG="yes"
PYTHON_DEPEND="2:2.5"

inherit autotools eutils gnome2 python

DESCRIPTION="The Eye of GNOME image viewer"
HOMEPAGE="http://www.gnome.org/projects/eog/"

LICENSE="GPL-2+"
SLOT="1"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="dbus exif jpeg lcms python svg tiff xmp"

RDEPEND=">=x11-libs/gtk+-2.18:2
	x11-libs/gdk-pixbuf:2[jpeg?,tiff?]
	>=dev-libs/glib-2.25.9:2
	>=dev-libs/libxml2-2
	>=gnome-base/gconf-2.31.1
	>=gnome-base/gnome-desktop-2.25.1:2
	>=x11-themes/gnome-icon-theme-2.19.1
	>=x11-misc/shared-mime-info-0.20
	x11-libs/libX11

	dbus? ( >=dev-libs/dbus-glib-0.71 )
	exif? (
		>=media-libs/libexif-0.6.14
		virtual/jpeg:0 )
	jpeg? ( virtual/jpeg:0 )
	lcms? ( =media-libs/lcms-1* )
	python? (
		>=dev-python/pygobject-2.15.1:2
		>=dev-python/pygtk-2.13 )
	svg? ( >=gnome-base/librsvg-2.26 )
	xmp? ( >=media-libs/exempi-2 )"

DEPEND="${RDEPEND}
	dev-util/gtk-doc-am
	app-text/gnome-doc-utils
	sys-devel/gettext
	>=dev-util/intltool-0.40
	virtual/pkgconfig"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	G2CONF="${G2CONF}
		$(use_with jpeg libjpeg)
		$(use_with exif libexif)
		$(use_with dbus)
		$(use_with lcms cms)
		$(use_enable python)
		$(use_with xmp)
		$(use_with svg librsvg)
		--disable-scrollkeeper
		--disable-schemas-install"
	DOCS="AUTHORS ChangeLog HACKING MAINTAINERS NEWS README THANKS TODO"

	# Fix build failure with ld.gold and glib-2.32
	epatch "${FILESDIR}/${P}-gmodule.patch"
	eautoreconf
	gnome2_src_prepare
}

src_install() {
	gnome2_src_install
	find "${ED}" -name "*.la" -delete || die "la files removal failed"
}
