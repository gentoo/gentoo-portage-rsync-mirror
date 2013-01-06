# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gmpc/gmpc-11.8.16.ebuild,v 1.8 2012/05/27 07:51:26 angelos Exp $

EAPI=4
inherit gnome2-utils

DESCRIPTION="A GTK+2 client for the Music Player Daemon"
HOMEPAGE="http://gmpc.wikia.com/wiki/Gnome_Music_Player_Client"
SRC_URI="http://download.sarine.nl/Programs/gmpc/11.8/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="nls xspf +unique"

RDEPEND="dev-db/sqlite:3
	>=dev-libs/glib-2.16:2
	dev-libs/libxml2:2
	>=media-libs/libmpd-11.8
	net-libs/libsoup:2.4
	>=x11-libs/gtk+-2.18:2
	x11-libs/libX11
	x11-themes/hicolor-icon-theme
	unique? ( dev-libs/libunique:1 )
	xspf? ( >=media-libs/libxspf-1.2 )"
DEPEND="${RDEPEND}
	dev-lang/vala:0.12
	>=dev-util/gob-2.0.17
	virtual/pkgconfig
	nls? ( dev-util/intltool
		sys-devel/gettext )"

DOCS=( AUTHORS README )

src_configure() {
	VALAC=$(type -p valac-0.12) \
	econf \
		--disable-static \
		--disable-libspiff \
		--disable-appindicator \
		--enable-mmkeys \
		$(use_enable nls) \
		$(use_enable unique) \
		$(use_enable xspf libxspf)
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
