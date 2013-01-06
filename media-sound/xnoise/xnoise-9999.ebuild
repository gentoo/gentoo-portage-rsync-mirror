# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/xnoise/xnoise-9999.ebuild,v 1.11 2012/08/16 19:08:27 angelos Exp $

EAPI=4
inherit fdo-mime gnome2-utils git-2

DESCRIPTION="A media player for Gtk+ with a slick GUI, great speed and lots of
features"
HOMEPAGE="http://www.xnoise-media-player.com/"
EGIT_REPO_URI="git://github.com/shuerhaaken/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="+lastfm libnotify +lyrics"

RDEPEND="x11-libs/gtk+:3
	>=dev-libs/glib-2.30:2
	media-libs/gstreamer:0.10
	media-libs/gst-plugins-base:0.10
	dev-db/sqlite:3
	media-libs/taglib
	x11-libs/cairo
	x11-libs/libX11
	lastfm? ( net-libs/libsoup:2.4 )
	libnotify? ( x11-libs/libnotify )
	lyrics? ( net-libs/libsoup:2.4
		dev-libs/libxml2:2 )"
DEPEND="${RDEPEND}
	dev-lang/vala:0.16
	dev-util/intltool
	virtual/pkgconfig
	gnome-base/gnome-common:3
	>=sys-devel/autoconf-2.67:2.5
	sys-devel/gettext"

DOCS=( AUTHORS README )

src_prepare() {
	NOCONFIGURE=yes ./autogen.sh || die
}

src_configure() {
	VALAC=$(type -p valac-0.16) \
	econf \
		$(use_enable lyrics lyricwiki) \
		$(use_enable lastfm) \
		$(use_enable libnotify notifications) \
		--enable-mpris \
		--enable-soundmenu2 \
		--enable-mediakeys \
		$(use_enable lyrics chartlyrics) \
		$(use_enable lyrics azlyrics) \
		--disable-ubuntuone
}

src_install() {
	default
	find "${ED}" -type f -name "*.la" -delete || die
	rm -rf "${ED}"/usr/share/${PN}/license || die
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}
