# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vlc/vlc-2.0.9999.ebuild,v 1.39 2014/09/02 07:41:51 mgorny Exp $

EAPI="5"

SCM=""
if [ "${PV%9999}" != "${PV}" ] ; then
	SCM="git-r3"

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
	SRC_URI="http://download.videolan.org/pub/videolan/${PN}/${PV/a/}/${P}.tar.xz"
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

IUSE="a52 aalib alsa altivec atmo +audioqueue avahi +avcodec
	+avformat bidi bluray cdda cddb dbus dc1394 debug dirac direct2d
	directfb directx dshow dts dvb +dvbpsi dvd dxva2 elibc_glibc egl +encode
	faad fbosd fluidsynth +ffmpeg flac fontconfig +gcrypt gme gnome gnutls
	growl httpd ieee1394 ios-vout jack kate kde libass libcaca libnotify
	libproxy libsamplerate libtiger linsys libtar lirc live lua +macosx
	+macosx-audio +macosx-dialog-provider +macosx-eyetv +macosx-quartztext
	+macosx-qtkit +macosx-vout matroska media-library mmx modplug mp3 mpeg
	mtp musepack ncurses neon ogg omxil opengl optimisememory opus oss
	png portaudio +postproc projectm pulseaudio pvr +qt4 rtsp run-as-root samba
	schroedinger sdl sdl-image sftp shine shout sid skins speex sqlite sse svg
	+swscale switcher taglib theora tremor truetype twolame udev upnp vaapi v4l
	vcdx visual vlm vorbis waveout wingdi wma-fixed +X x264 +xcb xml xosd xv
	zvbi"

RDEPEND="
		dev-libs/libgpg-error:0
		net-dns/libidn:0
		>=sys-libs/zlib-1.2.5.1-r2:0[minizip]
		virtual/libintl:0
		a52? ( >=media-libs/a52dec-0.7.4-r3:0 )
		aalib? ( media-libs/aalib:0 )
		alsa? ( >=media-libs/alsa-lib-1.0.23:0 )
		avahi? ( >=net-dns/avahi-0.6:0[dbus] )
		avcodec? ( virtual/ffmpeg:0 )
		avformat? ( virtual/ffmpeg:0 )
		bidi? ( >=dev-libs/fribidi-0.10.4:0 )
		bluray? ( >=media-libs/libbluray-0.2.1:0 )
		cddb? ( >=media-libs/libcddb-1.2.0:0 )
		dbus? ( >=sys-apps/dbus-1.0.2:0 )
		dc1394? ( >=sys-libs/libraw1394-2.0.1:0 >=media-libs/libdc1394-2.0.2:2 )
		dirac? ( >=media-video/dirac-0.10.0:0 )
		directfb? ( dev-libs/DirectFB:0 sys-libs/zlib:0 )
		dts? ( media-libs/libdca:0 )
		dvbpsi? ( >=media-libs/libdvbpsi-0.2.1:0 )
		dvd? ( media-libs/libdvdread:0 >=media-libs/libdvdnav-0.1.9:0 )
		egl? ( virtual/opengl:0 )
		elibc_glibc? ( >=sys-libs/glibc-2.8:2.2 )
		faad? ( >=media-libs/faad2-2.6.1:0 )
		flac? ( media-libs/libogg:0 >=media-libs/flac-1.1.2:0 )
		fluidsynth? ( media-sound/fluidsynth:0 )
		fontconfig? ( media-libs/fontconfig:1.0 )
		gcrypt? ( >=dev-libs/libgcrypt-1.2.0:0 )
		gme? ( media-libs/game-music-emu:0 )
		gnome? ( gnome-base/gnome-vfs:2 dev-libs/glib:2 )
		gnutls? ( >=net-libs/gnutls-2.0.0:0 )
		ieee1394? ( >=sys-libs/libraw1394-2.0.1:0 >=sys-libs/libavc1394-0.5.3:0 )
		ios-vout? ( virtual/opengl:0 )
		jack? ( >=media-sound/jack-audio-connection-kit-0.99.0-r1:0 )
		kate? ( >=media-libs/libkate-0.1.1:0 )
		libass? ( >=media-libs/libass-0.9.8:0 media-libs/fontconfig:1.0 )
		libcaca? ( >=media-libs/libcaca-0.99_beta14:0 )
		libnotify? ( x11-libs/libnotify:0 x11-libs/gtk+:2 x11-libs/gdk-pixbuf:2 dev-libs/glib:2 )
		libproxy? ( net-libs/libproxy:0 )
		libsamplerate? ( media-libs/libsamplerate:0 )
		libtar? ( >=dev-libs/libtar-1.2.11-r3:0 )
		libtiger? ( media-libs/libtiger:0 )
		linsys? ( >=media-libs/zvbi-0.2.28:0 )
		lirc? ( app-misc/lirc:0 )
		live? ( >=media-plugins/live-2011.12.23:0 )
		lua? ( >=dev-lang/lua-5.1:0 )
		macosx-vout? ( virtual/opengl:0 )
		matroska? (	>=dev-libs/libebml-1.0.0:0= >=media-libs/libmatroska-1.0.0:0= )
		modplug? ( >=media-libs/libmodplug-0.8.8.1:0 )
		mp3? ( media-libs/libmad:0 )
		mpeg? ( >=media-libs/libmpeg2-0.3.2:0 )
		mtp? ( >=media-libs/libmtp-1.0.0:0 )
		musepack? ( >=media-sound/musepack-tools-444:0 )
		ncurses? ( sys-libs/ncurses:5[unicode] )
		ogg? ( media-libs/libogg:0 )
		opengl? ( virtual/opengl:0 >=x11-libs/libX11-1.3.99.901:0 )
		opus? ( >=media-libs/opus-1.0.3:0 )
		png? ( media-libs/libpng:0= sys-libs/zlib:0 )
		portaudio? ( >=media-libs/portaudio-19_pre:0 )
		postproc? ( || ( media-video/ffmpeg:0 media-libs/libpostproc:0 ) )
		projectm? ( media-libs/libprojectm:0 media-fonts/dejavu:0 )
		pulseaudio? ( >=media-sound/pulseaudio-0.9.22:0 )
		qt4? ( dev-qt/qtgui:4 dev-qt/qtcore:4 )
		samba? ( || ( >=net-fs/samba-3.4.6:0[smbclient] >=net-fs/samba-4.0.0:0[client] ) )
		schroedinger? ( >=media-libs/schroedinger-1.0.10:0 )
		sdl? ( >=media-libs/libsdl-1.2.8:0
			sdl-image? ( media-libs/sdl-image:0 sys-libs/zlib:0 ) )
		sftp? ( net-libs/libssh2:0 )
		shout? ( media-libs/libshout:0 )
		sid? ( media-libs/libsidplay:2 )
		skins? ( x11-libs/libXext:0 x11-libs/libXpm:0 x11-libs/libXinerama:0 )
		speex? ( media-libs/speex:0 )
		sqlite? ( >=dev-db/sqlite-3.6.0:3 )
		svg? ( >=gnome-base/librsvg-2.9.0:2 )
		swscale? ( virtual/ffmpeg:0 )
		taglib? ( >=media-libs/taglib-1.5:0 sys-libs/zlib:0 )
		theora? ( >=media-libs/libtheora-1.0_beta3:0 )
		tremor? ( media-libs/tremor:0 )
		truetype? ( <media-libs/freetype-2.5.3:2 virtual/ttf-fonts:0
			!fontconfig? ( media-fonts/dejavu:0 ) )
		twolame? ( media-sound/twolame:0 )
		udev? ( virtual/udev:0 )
		upnp? ( net-libs/libupnp:0 )
		v4l? ( media-libs/libv4l:0 )
		vaapi? ( x11-libs/libva:0 virtual/ffmpeg[vaapi] )
		vcdx? ( >=dev-libs/libcdio-0.78.2:0 >=media-video/vcdimager-0.7.22:0 )
		visual? ( media-libs/libvisual:0.4 )
		vorbis? ( media-libs/libvorbis:0 )
		X? ( x11-libs/libX11:0 )
		x264? ( >=media-libs/x264-0.0.20090923:0= )
		xcb? ( >=x11-libs/libxcb-1.6:0 >=x11-libs/xcb-util-0.3.4:0 x11-libs/xcb-util-keysyms:0 )
		xml? ( dev-libs/libxml2:2 )
		xosd? ( x11-libs/xosd:0 )
		zvbi? ( >=media-libs/zvbi-0.2.25:0 )
"

DEPEND="${RDEPEND}
	fbosd? ( sys-kernel/linux-headers:0 )
	kde? ( >=kde-base/kdelibs-4:4 )
	xcb? ( x11-proto/xproto:0 )
	app-arch/xz-utils:0
	>=sys-devel/gettext-0.18.1:*
	virtual/pkgconfig:*"

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

S="${WORKDIR}/${MY_P/a/}"

pkg_setup() {
	if [[ "$(tc-getCC)" == *"gcc"* ]] ; then
		if [[ $(gcc-major-version) < 4 || ( $(gcc-major-version) == 4 && $(gcc-minor-version) < 5 ) ]] ; then
			die "You need to have at least >=sys-devel/gcc-4.5 to build and/or have a working vlc, see bug #426754."
		fi
	fi
}

src_unpack() {
	if [ "${PV%9999}" != "${PV}" ] ; then
		git-r3_src_unpack
	else
		unpack ${A}
	fi
}

src_prepare() {
	# Remove unnecessary warnings about unimplemented pragmas on gcc for now.
	# Need to recheck this with gcc 4.9 and every subsequent minor bump of gcc.
	#
	# config.h:792: warning: ignoring #pragma STDC FENV_ACCESS [-Wunknown-pragmas]
	# config.h:793: warning: ignoring #pragma STDC FP_CONTRACT [-Wunknown-pragmas]
	#
	# http://gcc.gnu.org/c99status.html
	if [[ "$(tc-getCC)" == *"gcc"* ]] ; then
		sed -i 's/ifndef __FAST_MATH__/if 0/g' configure.ac || die
	fi

	# _FORTIFY_SOURCE is set to 2 by default on Gentoo, remove redefine warnings.
	sed -i '/_FORTIFY_SOURCE.*, 2,/d' configure.ac || die

	# Bootstrap when we are on a git checkout.
	if [[ "${PV%9999}" != "${PV}" ]] ; then
		./bootstrap
	fi

	# Make it build with libtool 1.5
	rm -f m4/lt* m4/libtool.m4 || die

	# Fix mistakes.
	if use truetype || use projectm ; then
		epatch "${FILESDIR}"/${PN}-2.0.8-freetype-proper-default-font.patch
	fi

	# Patch up incompatibilities and reconfigure autotools.
	epatch "${FILESDIR}"/${PN}-2.0.8-support-uclibc.patch

	# We are not in a real git checkout due to the absence of a .git directory.
	touch src/revision.txt || die

	eautoreconf
}

src_configure() {
	# Compatibility fix for Samba 4.
	use samba && append-cppflags "-I/usr/include/samba-4.0"

	# Needs libresid-builder from libsidplay:2 which is in another directory...
	# FIXME!
	append-ldflags "-L/usr/$(get_libdir)/sidplay/builders/"

	econf \
		${myconf} \
		--enable-vlc \
		--docdir=/usr/share/doc/${PF} \
		--disable-dependency-tracking \
		--disable-loader \
		--disable-optimizations \
		--disable-update-check \
		--enable-fast-install \
		--enable-screen \
		$(use_enable a52) \
		$(use_enable aalib aa) \
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
		$(use_enable faad) \
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
		$(use_enable sftp) \
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
		$(use_enable tremor) \
		$(use_enable truetype freetype) \
		$(use_enable twolame) \
		$(use_enable udev) \
		$(use_enable upnp) \
		$(use_enable v4l v4l2) \
		$(use_enable vaapi libva) \
		$(use_enable vcdx) \
		$(use_enable visual) \
		$(use_enable vlm) \
		$(use_enable vorbis) \
		$(use_enable waveout) \
		$(use_enable wingdi) \
		$(use_enable wma-fixed) \
		$(use_with X x) \
		$(use_enable x264) \
		$(use_enable xcb) \
		$(use_enable xml libxml2) \
		$(use_enable xosd) \
		$(use_enable xv xvideo) \
		$(use_enable zvbi) $(use_enable !zvbi telx) \
		--disable-crystalhd \
		--disable-decklink \
		--disable-goom \
		--disable-hildon \
		--disable-iomx \
		--disable-kai \
		--disable-kva \
		--disable-opencv

		# ^ We don't have these disables libraries in the Portage tree yet.
}

DOCS="AUTHORS THANKS NEWS README doc/fortunes.txt doc/intf-vcd.txt"

src_install() {
	default

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
