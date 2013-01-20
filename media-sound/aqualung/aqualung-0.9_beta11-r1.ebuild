# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/aqualung/aqualung-0.9_beta11-r1.ebuild,v 1.13 2013/01/20 10:05:03 billie Exp $

EAPI=4

inherit autotools eutils versionator

MY_PV=$(delete_version_separator 2)
MY_PV=${MY_PV/_p/.}

DESCRIPTION="A music player for a wide range of formats designed for gapless playback"
HOMEPAGE="http://aqualung.factorial.hu/"
SRC_URI="mirror://sourceforge/aqualung/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE="alsa cdda cddb debug flac ffmpeg ifp jack ladspa lame libsamplerate lua
	mac modplug mp3 musepack oss podcast pulseaudio sndfile speex systray vorbis wavpack"
KEYWORDS="amd64 x86"

RDEPEND="alsa? ( media-libs/alsa-lib )
	cdda? ( <dev-libs/libcdio-0.90[-minimal] )
	cddb? ( media-libs/libcddb )
	flac? ( media-libs/flac )
	ffmpeg? ( >=virtual/ffmpeg-0.6.90 )
	ifp? ( media-libs/libifp )
	jack? ( media-sound/jack-audio-connection-kit )
	ladspa? ( media-libs/liblrdf )
	lame? ( media-sound/lame )
	libsamplerate? ( media-libs/libsamplerate )
	lua? ( dev-lang/lua )
	mac? ( media-sound/mac )
	modplug? ( media-libs/libmodplug )
	mp3? ( media-libs/libmad )
	musepack? ( >=media-sound/musepack-tools-444 )
	pulseaudio? ( media-sound/pulseaudio )
	sndfile? ( media-libs/libsndfile )
	speex? ( media-libs/speex media-libs/liboggz )
	vorbis? ( media-libs/libvorbis )
	wavpack? ( media-sound/wavpack )
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	dev-libs/libxml2
	virtual/pkgconfig"

S=${WORKDIR}/${PN}-${MY_PV}

src_prepare() {
	epatch "${FILESDIR}"/${P}-use_lrdf_cflags.patch \
		"${FILESDIR}"/${P}-ffmpeg.patch \
		"${FILESDIR}"/${P}-libavformat54.patch
	sed -i \
		-e 's:$(pkgdatadir)/doc:/usr/share/doc/${PF}:' \
		doc/Makefile.am || die
	sed -i \
		-e '/BUILD_CFLAGS/s:-O2::' \
		-e '/BUILD_CFLAGS/s: -ggdb -g -O0::' \
		configure.ac || die
	eautoreconf
}

src_configure() {
	econf \
		$(use_with alsa) \
		$(use_with cdda) \
		$(use_with cddb) \
		$(use_enable debug) \
		$(use_with flac) \
		$(use_with ffmpeg lavc) \
		$(use_with ifp) \
		$(use_with jack) \
		$(use_with ladspa) \
		$(use_with lame) \
		$(use_with libsamplerate src) \
		$(use_with lua) \
		$(use_with mac) \
		$(use_with modplug mod) \
		$(use_with mp3 mpeg) \
		$(use_with musepack mpc) \
		$(use_with oss) \
		$(use_with podcast) \
		$(use_with pulseaudio pulse) \
		$(use_with sndfile) \
		$(use_with speex) \
		$(use_with systray) \
		$(use_with vorbis ogg) \
		$(use_with vorbis vorbisenc) \
		$(use_with wavpack) \
		--with-loop \
		--docdir=/usr/share/doc/${PF}
}

src_install() {
	default

	newicon src/img/icon_64.png aqualung.png
	make_desktop_entry aqualung Aqualung
}
