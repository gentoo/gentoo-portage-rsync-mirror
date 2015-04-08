# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gmtk/gmtk-1.0.8.ebuild,v 1.3 2014/03/06 14:32:40 nimiux Exp $

EAPI=5
inherit eutils

DESCRIPTION="GTK+ widget and function libraries for gnome-mplayer"
HOMEPAGE="http://code.google.com/p/gmtk/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~ppc ~ppc64 x86"
IUSE="alsa +dconf pulseaudio"

COMMON_DEPEND=">=dev-libs/glib-2.30
	>=x11-libs/gtk+-3.2:3
	x11-libs/libX11
	alsa? ( media-libs/alsa-lib )
	pulseaudio? ( media-sound/pulseaudio )"
RDEPEND="${COMMON_DEPEND}
	dconf? ( gnome-base/dconf )"
DEPEND="${COMMON_DEPEND}
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig"

DOCS="ChangeLog"

src_configure() {
	econf \
		--disable-static \
		--enable-gtk3 \
		$(use_enable dconf gsettings) \
		--disable-gconf \
		$(use_enable !dconf keystore) \
		--with-gio \
		$(use_with alsa) \
		$(use_with pulseaudio)
}

src_install() {
	default

	rm -rf "${ED}"/usr/share/doc/${PN}
	prune_libtool_files
}
