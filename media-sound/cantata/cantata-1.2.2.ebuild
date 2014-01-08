# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cantata/cantata-1.2.2.ebuild,v 1.1 2014/01/08 04:20:06 mrueg Exp $

EAPI=5
KDE_REQUIRED="optional"
KDE_LINGUAS="cs de en_GB es hu ko pl ru zh_CN"
inherit kde4-base

DESCRIPTION="A featureful and configurable Qt4 client for the music player daemon (MPD)"
HOMEPAGE="https://code.google.com/p/cantata/"
SRC_URI="https://cantata.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="cddb cdda kde lame mtp musicbrainz qt5 replaygain taglib"
REQUIRED_USE="
	cddb? ( cdda taglib )
	cdda? ( || ( cddb musicbrainz )  )
	lame? ( cdda taglib )
	mtp? ( taglib )
	musicbrainz? ( cdda taglib )
	qt5? ( !kde )
	replaygain? ( taglib )
"

DEPEND="
	cdda? ( media-sound/cdparanoia )
	cddb? ( media-libs/libcddb )
	kde? ( $(add_kdebase_dep kwalletd) )
	lame? ( media-sound/lame )
	mtp? ( media-libs/libmtp )
	musicbrainz? ( media-libs/musicbrainz:5 )
	qt5? (
		dev-qt/qtconcurrent:5
		dev-qt/qtnetwork:5
		dev-qt/qtwidgets:5
		dev-qt/qtxml:5
	)
	!qt5? (
		dev-qt/qtcore:4
		dev-qt/qtdbus:4
		dev-qt/qtgui:4
	)
	replaygain? (
		media-libs/speex
		media-sound/mpg123
		virtual/ffmpeg
	)
	taglib? (
		media-libs/taglib[asf,mp4]
		media-libs/taglib-extras
		!kde? ( sys-fs/udisks:2 )
	)
	dev-libs/qjson
	sys-libs/zlib
	x11-libs/libX11
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep oxygen-icons)
"

src_prepare() {
	kde4-base_src_prepare

	rm -rf 3rdparty/qjson || die
	use kde && { rm -rf 3rdparty/solid-lite/ || die ;}
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_enable cdda CDPARANOIA)
		$(cmake-utils_use_enable cddb)
		$(cmake-utils_use_enable kde)
		$(cmake-utils_use_enable kde kwallet)
		$(cmake-utils_use_enable lame)
		$(cmake-utils_use_enable mtp)
		$(cmake-utils_use_enable musicbrainz)
		$(cmake-utils_use_enable qt5)
		$(cmake-utils_use_enable replaygain FFMPEG)
		$(cmake-utils_use_enable replaygain MPG123)
		$(cmake-utils_use_enable replaygain SPEEXDSP)
		$(cmake-utils_use_enable taglib)
		$(cmake-utils_use_enable taglib TAGLIB_EXTRAS)
		-DENABLE_HTTPS_SUPPORT=ON
		-DENABLE_HTTP_STREAM_PLAYBACK=OFF
		-DENABLE_UDISKS2=ON
	)
	kde4-base_src_configure
}
