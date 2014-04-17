# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/easytag/easytag-2.2.0.ebuild,v 1.5 2014/04/17 07:19:59 ssuominen Exp $

EAPI=5
inherit gnome.org gnome2-utils fdo-mime

DESCRIPTION="GTK+ utility for editing MP2, MP3, MP4, FLAC, Ogg and other media tags"
HOMEPAGE="https://wiki.gnome.org/Apps/EasyTAG"

LICENSE="GPL-2 GPL-2+ LGPL-2 LGPL-2+ LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~x86 ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="flac mp3 opus speex test wavpack"

RDEPEND=">=dev-libs/glib-2.32:2
	>=media-libs/libogg-1.3.1
	>=media-libs/libvorbis-1.3.4
	>=media-libs/taglib-1.9.1[mp4]
	>=x11-libs/gtk+-3.4:3
	flac? ( >=media-libs/flac-1.3 )
	mp3? (
		>=media-libs/id3lib-3.8.3-r8
		>=media-libs/libid3tag-0.15.1b-r4
		)
	opus? (
		>=media-libs/opus-1.1
		>=media-libs/opusfile-0.4
		)
	speex? ( >=media-libs/speex-1.2_rc1 )
	wavpack? ( >=media-sound/wavpack-4.70 )"
DEPEND="${RDEPEND}
	app-text/docbook-xml-dtd:4.4
	app-text/yelp-tools
	dev-libs/libxml2
	dev-libs/libxslt
	>=dev-util/intltool-0.50
	>=sys-devel/gettext-0.18.3.2
	virtual/pkgconfig
	!<dev-util/pkgconfig-0.27
	test? (
		>=dev-util/appdata-tools-0.1.7
		|| ( >=dev-util/desktop-file-utils-22 <dev-util/desktop-file-utils-22 )
		)"

src_prepare() {
	sed -i \
		-e '/^DEPRECATED_CPPFLAGS="/d' \
		-e '/warning_flags/s: -Werror=.*:":' \
		configure || die
}

DOCS=( AUTHORS ChangeLog HACKING NEWS README THANKS TODO )

src_configure() {
	# Kludge to make easytag find its locales (bug #503698)
	export DATADIRNAME=share

	# FIXME: src/gio_wrapper.h -> taglib #include without #ifdef -> --enable-mp4
	# FIXME: src/vcedit.h -> ogg and vorbis #include without #ifdef -> --enable-ogg
	econf \
		$(use_enable test appdata-validate) \
		$(use_enable test tests) \
		$(use_enable mp3) \
		$(use_enable mp3 id3v23) \
		--enable-ogg \
		$(use_enable opus) \
		$(use_enable speex) \
		$(use_enable flac) \
		--enable-mp4 \
		$(use_enable wavpack)
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; fdo-mime_desktop_database_update; }
pkg_postrm() { gnome2_icon_cache_update; fdo-mime_desktop_database_update; }
