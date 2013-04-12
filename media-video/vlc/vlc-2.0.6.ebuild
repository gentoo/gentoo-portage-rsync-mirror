# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vlc/vlc-2.0.6.ebuild,v 1.1 2013/04/12 21:25:19 lu_zero Exp $

EAPI="4"

SCM=""
if [ "${PV%9999}" != "${PV}" ] ; then
	SCM=git-2
	EGIT_BOOTSTRAP="bootstrap"
	if [ "${PV%.9999}" != "${PV}" ] ; then
		EGIT_REPO_URI="git://git.videolan.org/vlc/vlc-${PV%.9999}.git"
	else
		EGIT_REPO_URI="git://git.videolan.org/vlc.git"
	fi
fi

inherit eutils multilib autotools toolchain-funcs flag-o-matic ${SCM}

MY_PV="${PV/_/-}"
MY_PV="${MY_PV/-beta/-test}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="VLC media player - Video player and streamer"
HOMEPAGE="http://www.videolan.org/vlc/"
if [ "${PV%9999}" != "${PV}" ] ; then # Live ebuild
	SRC_URI=""
elif [[ "${MY_P}" == "${P}" ]]; then
	SRC_URI="http://download.videolan.org/pub/videolan/${PN}/${PV}/${P}.tar.xz"
else
	SRC_URI="http://download.videolan.org/pub/videolan/testing/${MY_P}/${MY_P}.tar.xz"
fi

LICENSE="LGPL-2.1 GPL-2"
SLOT="0"

if [ "${PV%9999}" = "${PV}" ] ; then
	KEYWORDS="~alpha ~amd64 ~arm ~ppc ~ppc64 -sparc ~x86 ~amd64-fbsd ~x86-fbsd"
else
	KEYWORDS=""
fi
IUSE="a52 aac aalib alsa altivec atmo +audioqueue avahi +avcodec
	+avformat bidi bluray cdda cddb dbus dc1394 debug dirac direct2d
	directfb directx dshow dts dvb +dvbpsi dvd dxva2 elibc_glibc egl +encode
	fbosd fluidsynth +ffmpeg flac fontconfig +gcrypt gme gnome gnutls
	growl httpd ieee1394 ios-vout jack kate kde libass libcaca libnotify
	libproxy libsamplerate libtiger linsys libtar lirc live lua +macosx
	+macosx-audio +macosx-dialog-provider +macosx-eyetv +macosx-quartztext
	+macosx-qtkit +macosx-vout matroska media-library mmx modplug mp3 mpeg
	mtp musepack ncurses neon ogg omxil opengl opus optimisememory oss png
	portaudio +postproc projectm pulseaudio pvr +qt4 rtsp run-as-root samba
	schroedinger sdl sdl-image shine shout sid skins speex sqlite sse svg
	+swscale switcher taglib theora truetype twolame udev upnp vaapi v4l
	vcdx vlm vorbis waveout win32codecs wingdi wma-fixed +X x264 +xcb xml
	xosd xv zvbi"

RDEPEND="
		>=sys-libs/zlib-1.2.5.1-r2[minizip]
		a52? ( >=media-libs/a52dec-0.7.4-r3 )
		aalib? ( media-libs/aalib )
		aac? ( >=media-libs/faad2-2.6.1 )
		alsa? ( >=media-libs/alsa-lib-1.0.23 )
		avahi? ( >=net-dns/avahi-0.6[dbus] )
		avcodec? ( virtual/ffmpeg )
		avformat? ( virtual/ffmpeg )
		bidi? ( >=dev-libs/fribidi-0.10.4 )
		bluray? ( >=media-libs/libbluray-0.2.1 )
		cddb? ( >=media-libs/libcddb-1.2.0 )
		dbus? ( >=sys-apps/dbus-1.0.2 )
		dc1394? ( >=sys-libs/libraw1394-2.0.1 >=media-libs/libdc1394-2.0.2 )
		dirac? ( >=media-video/dirac-0.10.0 )
		directfb? ( dev-libs/DirectFB sys-libs/zlib )
		dts? ( media-libs/libdca )
		dvbpsi? ( >=media-libs/libdvbpsi-0.2.1 )
		dvd? (	media-libs/libdvdread >=media-libs/libdvdnav-0.1.9 )
		egl? ( virtual/opengl )
		elibc_glibc? ( >=sys-libs/glibc-2.8 )
		flac? ( media-libs/libogg >=media-libs/flac-1.1.2 )
		fluidsynth? ( media-sound/fluidsynth )
		fontconfig? ( media-libs/fontconfig )
		gcrypt? ( >=dev-libs/libgcrypt-1.2.0 )
		gme? ( media-libs/game-music-emu )
		gnome? ( gnome-base/gnome-vfs )
		gnutls? ( >=net-libs/gnutls-2.0.0 )
		ieee1394? ( >=sys-libs/libraw1394-2.0.1 >=sys-libs/libavc1394-0.5.3 )
		ios-vout? ( virtual/opengl )
		jack? ( >=media-sound/jack-audio-connection-kit-0.99.0-r1 )
		kate? ( >=media-libs/libkate-0.1.1 )
		libass? ( >=media-libs/libass-0.9.8 media-libs/fontconfig )
		libcaca? ( >=media-libs/libcaca-0.99_beta14 )
		libnotify? ( x11-libs/libnotify x11-libs/gtk+:2 )
		libproxy? ( net-libs/libproxy )
		libsamplerate? ( media-libs/libsamplerate )
		libtar? ( >=dev-libs/libtar-1.2.11-r3 )
		libtiger? ( media-libs/libtiger )
		linsys? ( >=media-libs/zvbi-0.2.28 )
		lirc? ( app-misc/lirc )
		live? ( >=media-plugins/live-2011.12.23 )
		lua? ( >=dev-lang/lua-5.1 )
		macosx-vout? ( virtual/opengl )
		matroska? (	>=dev-libs/libebml-1.0.0 >=media-libs/libmatroska-1.0.0 )
		modplug? ( >=media-libs/libmodplug-0.8.8.1 )
		mp3? ( media-libs/libmad )
		mpeg? ( >=media-libs/libmpeg2-0.3.2 )
		mtp? ( >=media-libs/libmtp-1.0.0 )
		musepack? ( >=media-sound/musepack-tools-444 )
		ncurses? ( >=sys-libs/ncurses-5.9-r2[unicode] )
		ogg? ( media-libs/libogg )
		opengl? ( virtual/opengl >=x11-libs/libX11-1.3.99.901 )
		opus? ( media-libs/opus )
		png? ( media-libs/libpng sys-libs/zlib )
		portaudio? ( >=media-libs/portaudio-19_pre )
		postproc? ( || ( media-video/ffmpeg media-libs/libpostproc ) )
		projectm? ( media-libs/libprojectm )
		pulseaudio? ( >=media-sound/pulseaudio-0.9.22 )
		qt4? ( dev-qt/qtgui:4 dev-qt/qtcore:4 )
		samba? ( >=net-fs/samba-3.4.6[smbclient] )
		schroedinger? ( >=media-libs/schroedinger-1.0.10 )
		sdl? ( >=media-libs/libsdl-1.2.8
			sdl-image? ( media-libs/sdl-image sys-libs/zlib	) )
		shout? ( media-libs/libshout )
		sid? ( media-libs/libsidplay:2 )
		skins? ( x11-libs/libXext x11-libs/libXpm x11-libs/libXinerama )
		speex? ( media-libs/speex )
		sqlite? ( >=dev-db/sqlite-3.6.0:3 )
		svg? ( >=gnome-base/librsvg-2.9.0 )
		swscale? ( virtual/ffmpeg )
		taglib? ( >=media-libs/taglib-1.5 sys-libs/zlib )
		theora? ( >=media-libs/libtheora-1.0_beta3 )
		truetype? ( media-libs/freetype virtual/ttf-fonts
			!fontconfig? ( media-fonts/dejavu ) )
		twolame? ( media-sound/twolame )
		udev? ( virtual/udev )
		upnp? ( net-libs/libupnp )
		v4l? ( media-libs/libv4l )
		vaapi? ( x11-libs/libva )
		vcdx? ( >=dev-libs/libcdio-0.78.2 >=media-video/vcdimager-0.7.22 )
		vorbis? ( media-libs/libvorbis )
		win32codecs? ( media-libs/win32codecs )
		X? ( x11-libs/libX11 )
		x264? ( >=media-libs/x264-0.0.20090923 )
		xcb? ( >=x11-libs/libxcb-1.6 >=x11-libs/xcb-util-0.3.4 )
		xml? ( dev-libs/libxml2 )
		xosd? ( x11-libs/xosd )
		zvbi? ( >=media-libs/zvbi-0.2.25 )
		"

DEPEND="${RDEPEND}
	alsa? ( >=media-sound/alsa-headers-1.0.23 )
	fbosd? ( sys-kernel/linux-headers )
	kde? ( >=kde-base/kdelibs-4 )
	xcb? ( x11-proto/xproto )
	app-arch/xz-utils
	virtual/pkgconfig"

REQUIRED_USE="
	aalib? ( X )
	bidi? ( truetype )
	cddb? ( cdda )
	dvb? ( dvbpsi )
	dxva2? ( avcodec )
	egl? ( X )
	ffmpeg? ( avcodec avformat swscale postproc )
	fontconfig? ( truetype )
	gnutls? ( gcrypt )
	httpd? ( lua )
	libcaca? ( X )
	libtar? ( skins )
	libtiger? ( kate )
	media-library? ( sqlite )
	qt4? ( X )
	sdl? ( X )
	skins? ( truetype qt4 X )
	switcher? ( avcodec )
	vaapi? ( avcodec X )
	vlm? ( encode )
	xosd? ( X )
	xv? ( xcb )
"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	if [ "${PV%9999}" != "${PV}" ] ; then
		git-2_src_unpack
	fi
}

src_prepare() {
	# Make it build with libtool 1.5
	rm -f m4/lt* m4/libtool.m4

	eautoreconf
}

src_configure() {
	# needs libresid-builder from libsidplay:2 which is in another directory...
	# FIXME!
	use sid && append-ldflags "-L/usr/$(get_libdir)/sidplay/builders/"

	econf \
		--docdir=/usr/share/doc/${PF} \
		$(use_enable a52) \
		$(use_enable aalib aa) \
		$(use_enable aac faad) \
		$(use_enable alsa) \
		$(use_enable altivec) \
		$(use_enable atmo) \
		$(use_enable audioqueue) \
		$(use_enable avahi bonjour) \
		$(use_enable avcodec) \
		$(use_enable avformat) \
		$(use_enable bidi fribidi) \
		$(use_enable bluray) \
		$(use_enable cdda vcd) \
		$(use_enable cddb libcddb) \
		$(use_enable dbus) $(use_enable dbus dbus-control) \
		$(use_enable dirac) \
		$(use_enable direct2d) \
		$(use_enable directfb) \
		$(use_enable directx) \
		$(use_enable dc1394) \
		$(use_enable debug) \
		$(use_enable dshow) \
		$(use_enable dts dca) \
		$(use_enable dvbpsi) \
		$(use_enable dvd dvdread) $(use_enable dvd dvdnav) \
		$(use_enable dxva2) \
		$(use_enable egl) \
		$(use_enable encode sout) \
		$(use_enable fbosd) \
		$(use_enable flac) \
		$(use_enable fluidsynth) \
		$(use_enable fontconfig) \
		$(use_enable gcrypt libgcrypt) \
		$(use_enable gme) \
		$(use_enable gnome gnomevfs) \
		$(use_enable gnutls) \
		$(use_enable growl) \
		$(use_enable httpd) \
		$(use_enable ieee1394 dv) \
		$(use_enable ios-vout) \
		$(use_enable jack) \
		$(use_enable kate) \
		$(use_with kde kde-solid) \
		$(use_enable libass) \
		$(use_enable libcaca caca) \
		$(use_enable libnotify notify) \
		$(use_enable libproxy) \
		$(use_enable libsamplerate samplerate) \
		$(use_enable libtar) \
		$(use_enable libtiger tiger) \
		$(use_enable linsys) \
		$(use_enable lirc) \
		$(use_enable live live555) \
		$(use_enable lua) \
		$(use_enable macosx-audio) \
		$(use_enable macosx-dialog-provider) \
		$(use_enable macosx-eyetv) \
		$(use_enable macosx-qtkit) \
		$(use_enable macosx-quartztext) \
		$(use_enable macosx-vout) \
		$(use_enable matroska mkv) \
		$(use_enable media-library) \
		$(use_enable mmx) \
		$(use_enable modplug mod) \
		$(use_enable mp3 mad) \
		$(use_enable mpeg libmpeg2) \
		$(use_enable mtp) \
		$(use_enable musepack mpc) \
		$(use_enable ncurses) \
		$(use_enable neon) \
		$(use_enable ogg) $(use_enable ogg mux_ogg) \
		$(use_enable omxil) \
		$(use_enable opengl glx) \
		$(use_enable opus) \
		$(use_enable optimisememory optimize-memory) \
		$(use_enable oss) \
		$(use_enable png) \
		$(use_enable portaudio) \
		$(use_enable postproc) \
		$(use_enable projectm) \
		$(use_enable pulseaudio pulse) \
		$(use_enable pvr) \
		$(use_enable qt4) \
		$(use_enable rtsp realrtsp) \
		$(use_enable run-as-root) \
		$(use_enable samba smb) \
		$(use_enable schroedinger) \
		$(use_enable sdl) \
		$(use_enable sdl-image) \
		$(use_enable shine) \
		$(use_enable sid) \
		$(use_enable shout) \
		$(use_enable skins skins2) \
		$(use_enable speex) \
		$(use_enable sqlite) \
		$(use_enable sse) \
		$(use_enable svg) \
		$(use_enable switcher) \
		$(use_enable swscale) \
		$(use_enable taglib) \
		$(use_enable theora) \
		$(use_enable truetype freetype) \
		$(use_enable twolame) \
		$(use_enable udev) \
		$(use_enable upnp) \
		$(use_enable v4l v4l2) \
		$(use_enable vaapi libva) \
		$(use_enable vcdx) \
		$(use_enable vlm) \
		$(use_enable vorbis) \
		$(use_enable waveout) \
		$(use_enable win32codecs loader) \
		$(use_enable wingdi) \
		$(use_enable wma-fixed) \
		$(use_with X x) \
		$(use_enable x264) \
		$(use_enable xcb) \
		$(use_enable xml libxml2) \
		$(use_enable xosd) \
		$(use_enable xv xvideo) \
		$(use_enable zvbi) $(use_enable !zvbi telx) \
		--disable-optimizations \
		--without-tuning \
		--enable-fast-install
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS THANKS NEWS README \
		doc/fortunes.txt doc/intf-vcd.txt

	# Punt useless libtool's .la files
	find "${D}" -name '*.la' -delete
}

pkg_postinst() {
	if [ "$ROOT" = "/" ] && [ -x "/usr/$(get_libdir)/vlc/vlc-cache-gen" ] ; then
		einfo "Running /usr/$(get_libdir)/vlc/vlc-cache-gen on /usr/$(get_libdir)/vlc/plugins/"
		"/usr/$(get_libdir)/vlc/vlc-cache-gen" -f "/usr/$(get_libdir)/vlc/plugins/"
	else
		ewarn "We cannot run vlc-cache-gen (most likely ROOT!=/)"
		ewarn "Please run /usr/$(get_libdir)/vlc/vlc-cache-gen manually"
		ewarn "If you do not do it, vlc will take a long time to load."
	fi
}
