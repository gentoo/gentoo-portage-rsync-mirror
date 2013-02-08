# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cantata/cantata-0.9.2.ebuild,v 1.1 2013/02/08 11:40:02 yngwin Exp $

EAPI=5
KDE_REQUIRED="optional"
inherit kde4-base

DESCRIPTION="A featureful and configurable Qt4 client for the music player daemon (MPD)"
HOMEPAGE="http://kde-apps.org/content/show.php?content=147733"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="kde mtp phonon replaygain webkit"
REQUIRED_USE="mtp? ( kde )"

DEPEND="
	x11-libs/qt-core:4
	x11-libs/qt-dbus:4
	x11-libs/qt-gui:4
	kde? (
		media-libs/taglib[asf,mp4]
		media-libs/taglib-extras
		mtp? ( media-libs/libmtp )
	)
	phonon? ( || ( media-libs/phonon x11-libs/qt-phonon:4 ) )
	replaygain? (
		media-libs/speex
		media-libs/taglib[asf,mp4]
		media-libs/taglib-extras
		media-sound/mpg123
		virtual/ffmpeg
	)
	webkit? ( x11-libs/qt-webkit:4 )
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep oxygen-icons)
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_enable kde)
		$(cmake-utils_use_enable phonon)
		$(cmake-utils_use_enable replaygain FFMPEG)
		$(cmake-utils_use_enable replaygain MPG123)
		$(cmake-utils_use_enable replaygain SPEEXDSP)
		$(cmake-utils_use_enable mtp)
	)

	# kde fails to build without taglib
	# taglib is required to enable replaygain
	if use kde || use replaygain; then
		mycmakeargs+=(
			-DENABLE_TAGLIB=ON
			-DENABLE_TAGLIB_EXTRAS=ON
		)
	fi

	kde4-base_src_configure
}
