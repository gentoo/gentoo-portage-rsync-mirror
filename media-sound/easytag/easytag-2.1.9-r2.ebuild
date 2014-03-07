# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/easytag/easytag-2.1.9-r2.ebuild,v 1.1 2014/03/07 08:51:45 polynomial-c Exp $

EAPI=5
inherit eutils autotools gnome.org fdo-mime

DESCRIPTION="GTK+ utility for editing MP2, MP3, MP4, FLAC, Ogg and other media tags"
HOMEPAGE="http://projects.gnome.org/easytag/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="flac mp3 mp4 nls speex vorbis wavpack"

SRC_URI+=" https://git.gnome.org/browse/easytag/patch/?id=dd4f3bd815bd186e3e58752e0ac7999c6c645fd7 -> ${PN}-2.1.9-g_output_stream_check_fix.patch
		https://git.gnome.org/browse/easytag/patch/?id=c01a3ee46ca0b8e35fafa5008d5b6ef5e8e66592 -> ${PN}-2.1.9-invalid_arguments_crash_fix.patch
		https://git.gnome.org/browse/easytag/patch/?id=6c70f15269bd66936b2e7d65e62c8a80bc38fc9f -> ${PN}-2.1.9-do_not_unref_gfile.patch
		https://git.gnome.org/browse/easytag/patch/?id=afad898b0394b6eafeaf6f89cf411ac5c0e96ab0 -> ${PN}-2.1.9-long_format_date_memleak_fix.patch
		https://git.gnome.org/browse/easytag/patch/?id=1d0a255ca85d964141945a29f6e92d2ba0d89714 -> ${PN}-2.1.9-parse_date_memleak_fix.patch"

RDEPEND=">=x11-libs/gtk+-2.24:2
	mp3? (
		>=media-libs/id3lib-3.8.3-r7
		media-libs/libid3tag
		)
	flac? (
		media-libs/flac
		media-libs/libvorbis
		)
	mp4? ( media-libs/taglib[mp4] )
	vorbis? ( media-libs/libvorbis )
	wavpack? ( media-sound/wavpack )
	speex? (
		media-libs/speex
		media-libs/libvorbis
		)"
DEPEND="${RDEPEND}
	app-text/yelp-tools
	dev-util/intltool
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.1.8-werror.patch
	# 500654
	epatch "${DISTDIR}/${P}-g_output_stream_check_fix.patch" \
		"${DISTDIR}/${P}-invalid_arguments_crash_fix.patch" \
		"${DISTDIR}/${P}-do_not_unref_gfile.patch" \
		"${DISTDIR}/${P}-long_format_date_memleak_fix.patch" \
		"${DISTDIR}/${P}-parse_date_memleak_fix.patch"
	eautoreconf
}

DOCS=( AUTHORS ChangeLog HACKING NEWS README THANKS TODO )

src_configure() {
		# Kludge to make easytag find its locales (bug #503698)
		export DATADIRNAME="share"

		econf \
		$(use_enable nls) \
		$(use_enable mp3) \
		$(use_enable mp3 id3v23) \
		$(use_enable vorbis ogg) \
		$(use_enable speex) \
		$(use_enable flac) \
		$(use_enable mp4) \
		$(use_enable wavpack)
}

pkg_postinst() { fdo-mime_desktop_database_update; }
pkg_postrm() { fdo-mime_desktop_database_update; }
