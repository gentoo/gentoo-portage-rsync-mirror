# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gnome-photos/gnome-photos-3.8.2.ebuild,v 1.1 2013/05/14 21:31:55 pacho Exp $

EAPI="5"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="Access, organize and share your photos on GNOME"
HOMEPAGE="https://live.gnome.org/GnomePhotos"

LICENSE="GPL-2+ LGPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	>=app-misc/tracker-0.16
	>=dev-libs/glib-2.35.1:2
	gnome-base/gnome-desktop:3=
	>=gnome-base/librsvg-2.26.0
	media-libs/babl
	>=media-libs/gegl-0.2
	>=media-libs/exempi-1.99.5
	media-libs/lcms:2
	>=media-libs/libexif-0.6.14
	net-libs/gnome-online-accounts
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	>=x11-libs/gtk+-3.8.0:3
"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35.0
	virtual/pkgconfig
"
