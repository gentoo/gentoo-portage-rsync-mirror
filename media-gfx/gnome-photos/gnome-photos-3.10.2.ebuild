# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gnome-photos/gnome-photos-3.10.2.ebuild,v 1.4 2014/03/09 10:52:16 pacho Exp $

EAPI="5"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="Access, organize and share your photos on GNOME"
HOMEPAGE="https://wiki.gnome.org/Apps/Photos"

LICENSE="GPL-2+ LGPL-2+"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="
	>=app-misc/tracker-0.16:=
	>=dev-libs/glib-2.35.1:2
	gnome-base/gnome-desktop:3=
	>=gnome-base/librsvg-2.26.0
	media-libs/babl
	>=media-libs/gegl-0.2
	>=media-libs/grilo-0.2.6:0.2
	>=media-plugins/grilo-plugins-0.2.6:0.2[upnp-av]
	>=media-libs/exempi-1.99.5
	media-libs/lcms:2
	>=media-libs/libexif-0.6.14
	>=net-libs/gnome-online-accounts-3.8
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	>=x11-libs/gtk+-3.9.11:3
"
DEPEND="${RDEPEND}
	dev-util/desktop-file-utils
	>=dev-util/intltool-0.50.1
	virtual/pkgconfig
"

src_install() {
	default
	rm -r "${D}/usr/share/doc/${PN}" || die
}
