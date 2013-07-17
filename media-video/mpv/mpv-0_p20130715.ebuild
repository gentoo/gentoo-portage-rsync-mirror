# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mpv/mpv-0_p20130715.ebuild,v 1.2 2013/07/17 18:16:28 tomwij Exp $

EAPI=5

EGIT_REPO_URI="git://github.com/mpv-player/mpv.git"

inherit toolchain-funcs flag-o-matic multilib base
[[ ${PV} == *9999* ]] && inherit git-2

DESCRIPTION="Video player based on MPlayer/mplayer2"
HOMEPAGE="http://mpv.io/"
[[ ${PV} == *9999* ]] || \
SRC_URI="http://dev.gentoo.org/~lu_zero/distfiles/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
[[ ${PV} == *9999* ]] || \
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux"
IUSE="+alsa aqua bluray bs2b +cdio dvb +dvd +enca encode +iconv jack joystick
jpeg ladspa lcms +libass libcaca libguess lirc mng +mp3 -openal +opengl oss
portaudio +postproc pulseaudio pvr +quvi radio samba +shm +threads v4l vcd
vdpau vf-dlopen wayland +X xinerama +xscreensaver +xv"

REQUIRED_USE="
	enca? ( iconv )
	lcms? ( opengl )
	libguess? ( iconv )
	opengl? ( || ( aqua wayland X ) )
	portaudio? ( threads )
	pvr? ( v4l )
	radio? ( v4l || ( alsa oss ) )
	v4l? ( threads )
	vdpau? ( X )
	wayland? ( opengl )
	xinerama? ( X )
	xscreensaver? ( X )
	xv? ( X )
"

RDEPEND+="
	|| (
		>=media-video/libav-9:=[encode?,threads?,vdpau?]
		>=media-video/ffmpeg-1.2[encode?,threads?,vdpau?]
	)
	sys-libs/ncurses
	sys-libs/zlib
	X? (
		x11-libs/libXext
		x11-libs/libXxf86vm
		opengl? ( virtual/opengl )
		lcms? ( media-libs/lcms:2 )
		vdpau? ( x11-libs/libvdpau )
		xinerama? ( x11-libs/libXinerama )
		xscreensaver? ( x11-libs/libXScrnSaver )
		xv? ( x11-libs/libXv )
	)
	alsa? ( media-libs/alsa-lib )
	bluray? ( media-libs/libbluray )
	bs2b? ( media-libs/libbs2b )
	cdio? (
		|| (
			dev-libs/libcdio-paranoia
			<dev-libs/libcdio-0.90[-minimal]
		)
	)
	dvb? ( virtual/linuxtv-dvb-headers )
	dvd? ( >=media-libs/libdvdread-4.1.3 )
	enca? ( app-i18n/enca )
	iconv? ( virtual/libiconv )
	jack? ( media-sound/jack-audio-connection-kit )
	jpeg? ( virtual/jpeg )
	ladspa? ( media-libs/ladspa-sdk )
	libass? (
		>=media-libs/libass-0.9.10[enca?,fontconfig]
		virtual/ttf-fonts
	)
	libcaca? ( media-libs/libcaca )
	libguess? ( >=app-i18n/libguess-1.0 )
	lirc? ( app-misc/lirc )
	mng? ( media-libs/libmng )
	mp3? ( media-sound/mpg123 )
	openal? ( >=media-libs/openal-1.13 )
	portaudio? ( >=media-libs/portaudio-19_pre20111121 )
	postproc? (
		|| (
			media-libs/libpostproc
			>=media-video/ffmpeg-1.2[encode?,threads?,vdpau?]
		)
	)
	pulseaudio? ( media-sound/pulseaudio )
	quvi? ( >=media-libs/libquvi-0.4.1:= )
	samba? ( net-fs/samba )
	wayland? (
		>=dev-libs/wayland-1.0.0
		media-libs/mesa[egl,wayland]
		>=x11-libs/libxkbcommon-0.3.0
	)
"
ASM_DEP="dev-lang/yasm"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=dev-lang/perl-5.8
	dev-python/docutils
	X? (
		x11-proto/videoproto
		x11-proto/xf86vidmodeproto
		xinerama? ( x11-proto/xineramaproto )
		xscreensaver? ( x11-proto/scrnsaverproto )
	)
	amd64? ( ${ASM_DEP} )
	x86? ( ${ASM_DEP} )
	x86-fbsd? ( ${ASM_DEP} )
"
DOCS=( AUTHORS Copyright README.md etc/example.conf etc/input.conf etc/encoding-example-profiles.conf )

pkg_setup() {
	if [[ ${PV} == *9999* ]]; then
		elog
		elog "This is a live ebuild which installs the latest from upstream's"
		elog "git repository, and is unsupported by Gentoo."
		elog "Everything but bugs in the ebuild itself will be ignored."
		elog
	fi

	if use !libass; then
		ewarn
		ewarn "You've disabled the libass flag. No OSD or subtitles will be displayed."
	fi

	if use openal; then
		ewarn
		ewarn "You've enabled the openal flag. OpenAL is disabled by default,"
		ewarn "because it supposedly inteferes with some other configure tests"
		ewarn "and makes them fail silently."
	fi

	einfo "For additional format support you need to enable the support on your"
	einfo "libavcodec/libavformat provider:"
	einfo "    media-video/libav or media-video/ffmpeg"
}

src_prepare() {
	# fix path to bash executable in configure scripts
	sed -i -e "1c\#!${EPREFIX}/bin/bash" \
		configure version.sh || die

	base_src_prepare
}

src_configure() {
	local myconf=""
	local uses i

	# ebuild uses "use foo || --disable-foo" to forcibly disable
	# compilation in almost every situation. The reason for this is
	# because if --enable is used, it will force the build of that option,
	# regardless of whether the dependency is available or not.

	#####################
	# Optional features #
	#####################
	# SDL output is fallback for platforms where nothing better is available
	myconf+=" --disable-sdl --disable-sdl2"
	use encode || myconf+=" --disable-encoding"
	myconf+=" $(use_enable joystick)"
	uses="bluray vcd"
	for i in ${uses}; do
		use ${i} || myconf+=" --disable-${i}"
	done
	use quvi || myconf+=" --disable-libquvi4 --disable-libquvi9"
	use samba || myconf+=" --disable-smb"
	use lirc || myconf+=" --disable-lirc --disable-lircc"

	########
	# CDDA #
	########
	use cdio || myconf+=" --disable-libcdio"

	############
	# DVD read #
	############
	use dvd || myconf+=" --disable-dvdread"

	#############
	# Subtitles #
	#############
	uses="enca iconv libass libguess"
	for i in ${uses}; do
		use ${i} || myconf+=" --disable-${i}"
	done

	#####################################
	# DVB / Video4Linux / Radio support #
	#####################################
	use dvb || myconf+=" --disable-dvb"
	use pvr || myconf+=" --disable-pvr"
	use v4l || myconf+=" --disable-tv --disable-tv-v4l2"
	if use radio; then
		myconf+=" --enable-radio --enable-radio-capture"
	else
		myconf+=" --disable-radio-v4l2"
	fi

	##########
	# Codecs #
	##########
	use mp3 || myconf+=" --disable-mpg123"
	uses="jpeg mng"
	for i in ${uses}; do
		use ${i} || myconf+=" --disable-${i}"
	done

	################
	# Video Output #
	################
	use libcaca || myconf+=" --disable-caca"
	use postproc || myconf+=" --disable-libpostproc"

	################
	# Audio Output #
	################
	myconf+=" --disable-rsound" # media-sound/rsound is in pro-audio overlay only
	uses="alsa jack ladspa portaudio"
	for i in ${uses}; do
		use ${i} || myconf+=" --disable-${i}"
	done
	use bs2b || myconf+=" --disable-libbs2b"
	use openal && myconf+=" --enable-openal"
	use oss || myconf+=" --disable-ossaudio"
	use pulseaudio || myconf+=" --disable-pulse"

	####################
	# Advanced Options #
	####################
	# keep build reproducible
	myconf+=" --disable-build-date"
	# do not add -g to CFLAGS
	myconf+=" --disable-debug"
	use threads || myconf+=" --disable-pthreads"

	# Platform specific flags, hardcoded on amd64 (see below)
	use shm || myconf+=" --disable-shm"

	if use x86 && gcc-specs-pie; then
		filter-flags -fPIC -fPIE
		append-ldflags -nopie
	fi

	###########################
	# X enabled configuration #
	###########################
	use X || myconf+=" --disable-x11"
	uses="vdpau wayland xinerama xv"
	for i in ${uses}; do
		use ${i} || myconf+=" --disable-${i}"
	done
	use opengl || myconf+=" --disable-gl"
	use lcms || myconf+=" --disable-lcms2"
	use xscreensaver || myconf+=" --disable-xss"

	############################
	# OSX (aqua) configuration #
	############################
	use aqua && myconf+=" --enable-macosx-bundle"

	CFLAGS= LDFLAGS= ./configure \
		--cc="$(tc-getCC)" \
		--extra-cflags="${CFLAGS}" \
		--extra-ldflags="${LDFLAGS}" \
		--pkg-config="$(tc-getPKG_CONFIG)" \
		--prefix="${EPREFIX}"/usr \
		--bindir="${EPREFIX}"/usr/bin \
		--confdir="${EPREFIX}"/etc/${PN} \
		--mandir="${EPREFIX}"/usr/share/man \
		--localedir="${EPREFIX}"/usr/share/locale \
		${myconf} || die

	MAKEOPTS+=" V=1"
}

src_compile() {
	base_src_compile

	if use vf-dlopen; then
		tc-export CC
		emake -C TOOLS/vf_dlopen
	fi
}

src_install() {
	base_src_install

	if use vf-dlopen; then
		exeinto /usr/$(get_libdir)/${PN}
		doexe TOOLS/vf_dlopen/*.so
	fi
}
