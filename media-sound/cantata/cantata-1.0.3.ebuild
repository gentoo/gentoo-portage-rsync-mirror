# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cantata/cantata-1.0.3.ebuild,v 1.2 2013/06/14 23:23:18 johu Exp $

EAPI=5
KDE_REQUIRED="optional"
inherit kde4-base

DESCRIPTION="A featureful and configurable Qt4 client for the music player daemon (MPD)"
HOMEPAGE="https://code.google.com/p/cantata/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="cddb cdparanoia kde lame mtp musicbrainz online-services phonon qt5 replaygain taglib"
REQUIRED_USE="
	cddb? ( cdparanoia taglib )
	cdparanoia? ( || ( cddb musicbrainz )  )
	lame? ( cdparanoia taglib )
	mtp? ( taglib )
	musicbrainz? ( cdparanoia taglib )
	online-services? ( taglib )
	qt5? ( !kde !phonon )
	replaygain? ( taglib )
"

DEPEND="
	lame? ( media-sound/lame )
	mtp? ( media-libs/libmtp )
	phonon? ( || ( media-libs/phonon dev-qt/qtphonon:4 ) )
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
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep oxygen-icons)
"

PATCHES=(
	"${FILESDIR}/${P}-audiocd-automagic.patch"
	"${FILESDIR}/${P}-system-qjson.patch"
)

src_prepare() {
	kde4-base_src_prepare

	rm -rf 3rdparty/qjson/

	# make desktop file pass validation
	sed -e 's/MPD/MPD;/' -i ${PN}.desktop || die
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_enable cddb)
		$(cmake-utils_use_enable cdparanoia)
		$(cmake-utils_use_enable kde)
		$(cmake-utils_use_enable lame)
		$(cmake-utils_use_enable mtp)
		$(cmake-utils_use_enable musicbrainz)
		$(cmake-utils_use_enable online-services ONLINE_SERVICES)
		$(cmake-utils_use_enable phonon)
		$(cmake-utils_use_enable qt5)
		$(cmake-utils_use_enable replaygain FFMPEG)
		$(cmake-utils_use_enable replaygain MPG123)
		$(cmake-utils_use_enable replaygain SPEEXDSP)
		$(cmake-utils_use_enable taglib)
		$(cmake-utils_use_enable taglib TAGLIB_EXTRAS)
		-DENABLE_UDISKS2=ON
	)
	kde4-base_src_configure
}
