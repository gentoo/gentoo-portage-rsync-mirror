# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ffmpeg/ffmpeg-0.10.16.ebuild,v 1.1 2015/03/12 22:08:11 aballier Exp $

EAPI="5"

SCM=""
if [ "${PV#9999}" != "${PV}" ] ; then
	SCM="git-2"
	EGIT_REPO_URI="git://git.videolan.org/ffmpeg.git"
fi

inherit eutils flag-o-matic multilib toolchain-funcs ${SCM} multilib-minimal

DESCRIPTION="Complete solution to record, convert and stream audio and video. Includes libavcodec"
HOMEPAGE="http://ffmpeg.org/"
if [ "${PV#9999}" != "${PV}" ] ; then
	SRC_URI=""
elif [ "${PV%_p*}" != "${PV}" ] ; then # Snapshot
	SRC_URI="mirror://gentoo/${P}.tar.bz2"
else # Release
	SRC_URI="http://ffmpeg.org/releases/${P/_/-}.tar.bz2"
fi
FFMPEG_REVISION="${PV#*_p}"

LICENSE="GPL-2 amr? ( GPL-3 ) encode? ( aac? ( GPL-3 ) )"
SLOT="0.10"
if [ "${PV#9999}" = "${PV}" ] ; then
	KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~arm-linux ~x86-linux"
fi
IUSE="
	aac aacplus alsa amr +bzip2 cdio celt cpudetection debug
	dirac doc +encode faac frei0r gnutls gsm +hardcoded-tables ieee1394 jack
	jpeg2k libass libv4l modplug mp3 +network openal openssl oss pic pulseaudio
	rtmp schroedinger sdl speex static-libs test theora threads
	truetype v4l vaapi vdpau vorbis vpx X x264 xvid +zlib
	"

# String for CPU features in the useflag[:configure_option] form
# if :configure_option isn't set, it will use 'useflag' as configure option
CPU_FEATURES="cpu_flags_x86_3dnow:amd3dnow cpu_flags_x86_3dnowext:amd3dnowext altivec cpu_flags_x86_avx:avx cpu_flags_x86_mmx:mmx cpu_flags_x86_mmxext:mmx2 cpu_flags_x86_ssse3:ssse3 vis neon"

for i in ${CPU_FEATURES}; do
	IUSE="${IUSE} ${i%:*}"
done

DOCS=""

RDEPEND="
	alsa? ( >=media-libs/alsa-lib-1.0.27.2[${MULTILIB_USEDEP}] )
	amr? ( >=media-libs/opencore-amr-0.1.3-r1[${MULTILIB_USEDEP}] )
	bzip2? ( >=app-arch/bzip2-1.0.6-r4[${MULTILIB_USEDEP}] )
	cdio? ( >=dev-libs/libcdio-paranoia-0.90_p1-r1[${MULTILIB_USEDEP}] )
	celt? ( >=media-libs/celt-0.11.1-r1[${MULTILIB_USEDEP}] )
	dirac? ( >=media-video/dirac-1.0.2-r1[${MULTILIB_USEDEP}] )
	encode? (
		aac? ( >=media-libs/vo-aacenc-0.1.3[${MULTILIB_USEDEP}] )
		aacplus? ( >=media-libs/libaacplus-2.0.2-r1[${MULTILIB_USEDEP}] )
		amr? ( >=media-libs/vo-amrwbenc-0.1.2-r1[${MULTILIB_USEDEP}] )
		faac? ( >=media-libs/faac-1.28-r3[${MULTILIB_USEDEP}] )
		mp3? ( >=media-sound/lame-3.99.5-r1[${MULTILIB_USEDEP}] )
		theora? ( >=media-libs/libtheora-1.1.1[encode,${MULTILIB_USEDEP}] >=media-libs/libogg-1.3.0[${MULTILIB_USEDEP}] )
		vorbis? ( >=media-libs/libvorbis-1.3.3-r1[${MULTILIB_USEDEP}] >=media-libs/libogg-1.3.0[${MULTILIB_USEDEP}] )
		x264? ( >=media-libs/x264-0.0.20130506:=[${MULTILIB_USEDEP}] )
		xvid? ( >=media-libs/xvid-1.3.2-r1[${MULTILIB_USEDEP}] )
	)
	frei0r? ( media-plugins/frei0r-plugins[${MULTILIB_USEDEP}] )
	gnutls? ( >=net-libs/gnutls-2.12.23-r6[${MULTILIB_USEDEP}] )
	gsm? ( >=media-sound/gsm-1.0.13-r1[${MULTILIB_USEDEP}] )
	ieee1394? ( >=media-libs/libdc1394-2.2.1[${MULTILIB_USEDEP}] >=sys-libs/libraw1394-2.1.0-r1[${MULTILIB_USEDEP}] )
	jack? ( >=media-sound/jack-audio-connection-kit-0.121.3-r1[${MULTILIB_USEDEP}] )
	jpeg2k? ( >=media-libs/openjpeg-1.5.0:0[${MULTILIB_USEDEP}] )
	libass? ( >=media-libs/libass-0.10.2[${MULTILIB_USEDEP}] )
	libv4l? ( >=media-libs/libv4l-0.9.5[${MULTILIB_USEDEP}] )
	modplug? ( >=media-libs/libmodplug-0.8.8.4-r1[${MULTILIB_USEDEP}] )
	openal? ( >=media-libs/openal-1.15.1[${MULTILIB_USEDEP}] )
	openssl? ( >=dev-libs/openssl-1.0.1h-r2[${MULTILIB_USEDEP}] )
	pulseaudio? ( >=media-sound/pulseaudio-2.1-r1[${MULTILIB_USEDEP}] )
	rtmp? ( >=media-video/rtmpdump-2.4_p20131018[${MULTILIB_USEDEP}] )
	schroedinger? ( >=media-libs/schroedinger-1.0.11-r1[${MULTILIB_USEDEP}] )
	sdl? ( >=media-libs/libsdl-1.2.15-r4[sound,video,${MULTILIB_USEDEP}] )
	speex? ( >=media-libs/speex-1.2_rc1-r1[${MULTILIB_USEDEP}] )
	truetype? ( >=media-libs/freetype-2.5.0.1:2[${MULTILIB_USEDEP}] )
	vaapi? ( >=x11-libs/libva-1.2.1-r1[${MULTILIB_USEDEP}] )
	vdpau? ( >=x11-libs/libvdpau-0.7[${MULTILIB_USEDEP}] )
	vpx? ( >=media-libs/libvpx-1.2.0_pre20130625[${MULTILIB_USEDEP}] )
	X? ( >=x11-libs/libX11-1.6.2[${MULTILIB_USEDEP}] >=x11-libs/libXext-1.3.2[${MULTILIB_USEDEP}] >=x11-libs/libXfixes-5.0.1[${MULTILIB_USEDEP}] )
	zlib? ( >=sys-libs/zlib-1.2.8-r1[${MULTILIB_USEDEP}] )
	!<media-video/ffmpeg-1.2
	!<media-video/libav-9
	abi_x86_32? ( !<=app-emulation/emul-linux-x86-medialibs-20130224-r11
		!app-emulation/emul-linux-x86-medialibs[-abi_x86_32(-)] )"
# !media-libs/libpostproc

DEPEND="${RDEPEND}
	>=sys-devel/make-3.81
	dirac? ( virtual/pkgconfig )
	doc? ( app-text/texi2html )
	gnutls? ( virtual/pkgconfig )
	ieee1394? ( virtual/pkgconfig )
	libv4l? ( virtual/pkgconfig )
	cpu_flags_x86_mmx? ( dev-lang/yasm )
	rtmp? ( virtual/pkgconfig )
	schroedinger? ( virtual/pkgconfig )
	test? ( net-misc/wget )
	truetype? ( virtual/pkgconfig )
	v4l? ( sys-kernel/linux-headers )
"
# faac is license-incompatible with ffmpeg
REQUIRED_USE="
	libv4l? ( v4l )
	test? ( encode zlib )"
RESTRICT="encode? ( faac? ( bindist ) aacplus? ( bindist ) ) openssl? ( bindist )"

S=${WORKDIR}/${P/_/-}

pkg_setup() {
	ewarn "This version is _terribly_ outdated with known security issues and"
	ewarn "bugs. It is provided only for binary compatibility."
	ewarn "Use at your own risks."
}

src_prepare() {
	if [ "${PV%_p*}" != "${PV}" ] ; then # Snapshot
		export revision=git-N-${FFMPEG_REVISION}
	fi
	epatch "${FILESDIR}/freiordl.patch"
	epatch "${FILESDIR}/flashtest.patch"

	if has_version dev-libs/libcdio-paranoia; then
		sed -i \
			-e 's:cdio/cdda.h:cdio/paranoia/cdda.h:' \
			-e 's:cdio/paranoia.h:cdio/paranoia/paranoia.h:' \
			configure libavdevice/libcdio.c || die
	fi
}

multilib_src_configure() {
	local myconf="${EXTRA_FFMPEG_CONF}"
	# Set to --enable-version3 if (L)GPL-3 is required
	local version3=""

	# enabled by default
	for i in debug doc network vaapi vdpau zlib; do
		use ${i} || myconf="${myconf} --disable-${i}"
	done
	use bzip2 || myconf="${myconf} --disable-bzlib"

	use cpudetection && myconf="${myconf} --enable-runtime-cpudetect"
	use openssl && myconf="${myconf} --enable-openssl --enable-nonfree"
	for i in gnutls ; do
		use $i && myconf="${myconf} --enable-$i"
	done

	# Encoders
	if use encode
	then
		use mp3 && myconf="${myconf} --enable-libmp3lame"
		use aac && { myconf="${myconf} --enable-libvo-aacenc" ; version3=" --enable-version3" ; }
		use amr && { myconf="${myconf} --enable-libvo-amrwbenc" ; version3=" --enable-version3" ; }
		for i in theora vorbis x264 xvid; do
			use ${i} && myconf="${myconf} --enable-lib${i}"
		done
		use aacplus && myconf="${myconf} --enable-libaacplus --enable-nonfree"
		use faac && myconf="${myconf} --enable-libfaac --enable-nonfree"
	else
		myconf="${myconf} --disable-encoders"
	fi

	# libavdevice options
	use cdio && myconf="${myconf} --enable-libcdio"
	use ieee1394 && myconf="${myconf} --enable-libdc1394"
	use openal && myconf="${myconf} --enable-openal"
	# Indevs
	# v4l1 is gone since linux-headers-2.6.38
	myconf="${myconf} --disable-indev=v4l"
	use v4l || myconf="${myconf} --disable-indev=v4l2"
	for i in alsa oss jack ; do
		use ${i} || myconf="${myconf} --disable-indev=${i}"
	done
	use X && myconf="${myconf} --enable-x11grab"
	use pulseaudio && myconf="${myconf} --enable-libpulse"
	use libv4l && myconf="${myconf} --enable-libv4l2"
	# Outdevs
	for i in alsa oss sdl ; do
		use ${i} || myconf="${myconf} --disable-outdev=${i}"
	done
	# libavfilter options
	use frei0r && myconf="${myconf} --enable-frei0r"
	use truetype && myconf="${myconf} --enable-libfreetype"
	use libass && myconf="${myconf} --enable-libass"

	# Threads; we only support pthread for now but ffmpeg supports more
	use threads && myconf="${myconf} --enable-pthreads"

	# Decoders
	use amr && { myconf="${myconf} --enable-libopencore-amrwb --enable-libopencore-amrnb" ; version3=" --enable-version3" ; }
	for i in celt gsm dirac modplug rtmp schroedinger speex vpx; do
		use ${i} && myconf="${myconf} --enable-lib${i}"
	done
	use jpeg2k && myconf="${myconf} --enable-libopenjpeg"

	# CPU features
	for i in ${CPU_FEATURES}; do
		use ${i%:*} || myconf="${myconf} --disable-${i#*:}"
	done
	if use pic ; then
		myconf="${myconf} --enable-pic"
		# disable asm code if PIC is required
		# as the provided asm decidedly is not PIC for x86.
		[[ ${ABI} == x86* ]] && myconf="${myconf} --disable-asm"
	fi
	[[ ${ABI} == "x32" ]] && myconf+=" --disable-asm" #427004

	# Try to get cpu type based on CFLAGS.
	# Bug #172723
	# We need to do this so that features of that CPU will be better used
	# If they contain an unknown CPU it will not hurt since ffmpeg's configure
	# will just ignore it.
	for i in $(get-flag march) $(get-flag mcpu) $(get-flag mtune) ; do
		[ "${i}" = "native" ] && i="host" # bug #273421
		myconf="${myconf} --cpu=${i}"
		break
	done

	# Mandatory configuration
	myconf="
		--enable-gpl
		${version3}
		--enable-avfilter
		--disable-stripping
		${myconf}"

	# cross compile support
	if tc-is-cross-compiler ; then
		myconf="${myconf} --enable-cross-compile --arch=$(tc-arch-kernel) --cross-prefix=${CHOST}-"
		case ${CHOST} in
			*freebsd*)
				myconf="${myconf} --target-os=freebsd"
				;;
			mingw32*)
				myconf="${myconf} --target-os=mingw32"
				;;
			*linux*)
				myconf="${myconf} --target-os=linux"
				;;
		esac
	fi

	# Misc stuff
	use hardcoded-tables && myconf="${myconf} --enable-hardcoded-tables"

	"${S}"/configure \
		--prefix="${EPREFIX}/usr" \
		--libdir="${EPREFIX}/usr/$(get_libdir)" \
		--shlibdir="${EPREFIX}/usr/$(get_libdir)" \
		--mandir="${EPREFIX}/usr/share/man" \
		--enable-shared \
		--cc="$(tc-getCC)" \
		--cxx="$(tc-getCXX)" \
		--ar="$(tc-getAR)" \
		--optflags="${CFLAGS}" \
		--extra-cflags="${CFLAGS}" \
		--extra-cxxflags="${CXXFLAGS}" \
		--disable-static \
		--disable-{ffplay,ffmpeg,ffprobe,ffserver} \
		--disable-{swresample,postproc,swscale,avdevice} \
		${myconf} || die
}

multilib_src_install() {
	emake DESTDIR="${D}" install-libs
	rm -f "${ED}"/usr/$(get_libdir)/*.so
}
