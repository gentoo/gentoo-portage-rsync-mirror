# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kwave/kwave-0.8.7.ebuild,v 1.2 2012/01/05 12:38:06 johu Exp $

EAPI=4

KDE_LINGUAS="cs de fr"
inherit kde4-base

DESCRIPTION="Kwave is a sound editor for KDE"
HOMEPAGE="http://kwave.sourceforge.net/"
SRC_URI="mirror://sourceforge/kwave/${P}-1.tar.bz2"

LICENSE="BSD FDL-1.2 GPL-2 LGPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="alsa debug flac +handbook mad oss pulseaudio vorbis"

RDEPEND="
	media-libs/audiofile
	>=sci-libs/fftw-3
	media-libs/libsamplerate
	alsa? ( media-libs/alsa-lib )
	flac? ( media-libs/flac )
	mad? (
		media-libs/id3lib
		media-libs/libmad
	)
	pulseaudio? ( media-sound/pulseaudio )
	vorbis? (
		media-libs/libogg
		media-libs/libvorbis
	)
"
DEPEND="${RDEPEND}
	$(add_kdebase_dep kdesdk-misc extras)
	|| ( media-gfx/imagemagick[png] media-gfx/graphicsmagick[imagemagick,png] )
"

DOCS=( AUTHORS CHANGES README TODO )

src_configure() {
	local mycmakeargs=(
		-DWITH_SAMPLERATE=ON
		-DWITH_PHONON=ON
		$(cmake-utils_use_with alsa)
		$(cmake-utils_use_with flac)
		$(cmake-utils_use_with mad MP3)
		$(cmake-utils_use_with vorbis OGG)
		$(cmake-utils_use_with oss)
		$(cmake-utils_use_with pulseaudio)
		$(cmake-utils_use debug)
	)

	kde4-base_src_configure
}
