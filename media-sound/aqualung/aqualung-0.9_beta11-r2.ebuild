# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/aqualung/aqualung-0.9_beta11-r2.ebuild,v 1.2 2013/01/20 10:05:03 billie Exp $

EAPI=5

inherit autotools eutils

MY_PV=${PV/_/}

DESCRIPTION="A music player for a wide range of formats designed for gapless playback"
HOMEPAGE="http://aqualung.factorial.hu/"
SRC_URI="mirror://sourceforge/aqualung/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa cddb debug flac ffmpeg ifp jack ladspa lame libsamplerate lua
	mac modplug mp3 musepack oss podcast pulseaudio sndfile speex systray vorbis wavpack"

RDEPEND="sys-libs/zlib
	app-arch/bzip2
	dev-libs/libxml2
	x11-libs/gtk+:2
	alsa? ( media-libs/alsa-lib )
	jack? ( media-sound/jack-audio-connection-kit )
	pulseaudio? ( media-sound/pulseaudio )
	flac? ( media-libs/flac )
	lame? ( media-sound/lame )
	ffmpeg? ( >=virtual/ffmpeg-0.6.90 )
	mac? ( media-sound/mac )
	modplug? ( media-libs/libmodplug )
	musepack? ( >=media-sound/musepack-tools-444 )
	mp3? ( media-libs/libmad )
	sndfile? ( media-libs/libsndfile )
	speex? ( media-libs/speex media-libs/liboggz )
	vorbis? ( media-libs/libvorbis )
	wavpack? ( media-sound/wavpack )
	ladspa? ( media-libs/liblrdf )
	libsamplerate? ( media-libs/libsamplerate )
	ifp? ( media-libs/libifp )
	cddb? ( media-libs/libcddb )
	lua? ( dev-lang/lua )"

DEPEND="${RDEPEND}
	sys-devel/gettext
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
		$(use_enable debug) \
		$(use_with alsa) \
		$(use_with jack) \
		$(use_with oss) \
		$(use_with pulseaudio pulse) \
		$(use_with flac) \
		$(use_with lame) \
		$(use_with ffmpeg lavc) \
		$(use_with mac) \
		$(use_with modplug mod) \
		$(use_with musepack mpc) \
		$(use_with podcast) \
		$(use_with mp3 mpeg) \
		$(use_with sndfile) \
		$(use_with speex) \
		$(use_with systray) \
		$(use_with vorbis ogg) \
		$(use_with vorbis vorbisenc) \
		--with-loop \
		$(use_with wavpack) \
		$(use_with ladspa) \
		$(use_with libsamplerate src) \
		--without-cdda \
		$(use_with ifp) \
		$(use_with cddb) \
		$(use_with lua) \
		--docdir=/usr/share/doc/${PF}
}

src_install() {
	default

	newicon src/img/icon_64.png aqualung.png
	make_desktop_entry aqualung Aqualung
}
