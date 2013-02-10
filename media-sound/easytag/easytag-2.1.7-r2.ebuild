# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/easytag/easytag-2.1.7-r2.ebuild,v 1.11 2013/02/10 04:41:46 radhermit Exp $

EAPI=4
inherit eutils fdo-mime

DESCRIPTION="GTK+ utility for editing MP2, MP3, MP4, FLAC, Ogg and other media tags"
HOMEPAGE="http://projects.gnome.org/easytag/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="flac mp3 mp4 speex vorbis wavpack"

RDEPEND=">=x11-libs/gtk+-2.12:2
	mp3? (
		>=media-libs/id3lib-3.8.3-r7
		media-libs/libid3tag
		)
	flac? (
		media-libs/flac
		media-libs/libvorbis
		)
	mp4? ( >=media-libs/libmp4v2-1.9.1:0 )
	vorbis? ( media-libs/libvorbis )
	wavpack? ( media-sound/wavpack )
	speex? (
		media-libs/speex
		media-libs/libvorbis
		)"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/gettext"

DOCS=( ChangeLog README THANKS TODO USERS-GUIDE )

src_prepare() {
	epatch \
		"${FILESDIR}"/${PN}-2.1.7-gold.patch \
		"${FILESDIR}"/${PN}-2.1.6-load-from-txt.patch

	has_version '>=media-libs/libmp4v2-1.9.1_p479' && \
		epatch "${FILESDIR}"/${PN}-2.1.7-new_libmp4v2.patch
}

src_configure() {
	econf \
		$(use_enable mp3) \
		$(use_enable mp3 id3v23) \
		$(use_enable vorbis ogg) \
		$(use_enable flac) \
		$(use_enable mp4) \
		$(use_enable wavpack) \
		$(use_enable speex)
}

pkg_postinst() { fdo-mime_desktop_database_update; }
pkg_postrm() { fdo-mime_desktop_database_update; }
