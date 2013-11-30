# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/drwright/drwright-3.5.0.ebuild,v 1.2 2013/11/30 19:15:42 pacho Exp $

EAPI=5
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit autotools eutils gnome2

DESCRIPTION="Tool forcing you to take regular breaks to prevent RSI"
HOMEPAGE="http://git.gnome.org/browse/drwright"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="
	>=dev-libs/glib-2.31.13:2
	>=x11-libs/gtk+-3.0.0:3
	>=x11-libs/gdk-pixbuf-2.25.3
	>=gnome-base/gnome-settings-daemon-3.7.3
	>=gnome-base/gnome-control-center-3.2
	>=x11-libs/libnotify-0.7
	media-libs/libcanberra[gtk3]
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXScrnSaver
"
DEPEND="${RDEPEND}
	x11-proto/scrnsaverproto
	sys-devel/gettext
	>=dev-util/intltool-0.35.0
	virtual/pkgconfig
	|| ( dev-util/gtk-builder-convert <=x11-libs/gtk+-2.24.10:2 )
"

src_prepare() {
	# Patches from 'master' to allow compilation with latest gsd
	epatch "${FILESDIR}/${P}-gsd-3.5.patch"
	epatch "${FILESDIR}/${P}-gsd-3.7.patch"

	eautoreconf
	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure --disable-static
}
