# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mplayer2/mplayer2-2.0_p20120309.ebuild,v 1.15 2013/05/16 19:14:38 ulm Exp $

EAPI=4

[[ ${PV} = *9999* ]] && VCS_ECLASS="git-2" || VCS_ECLASS=""

inherit toolchain-funcs eutils flag-o-matic multilib base ${VCS_ECLASS}

NAMESUF="${PN/mplayer/}"
DESCRIPTION="Media Player for Linux"
HOMEPAGE="http://www.mplayer2.org/"

if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI="git://git.mplayer2.org/mplayer2.git"
else
	RELEASE_URI="http://dev.gentooexperimental.org/~scarabeus/${P}.tar.xz"
fi
SRC_URI="${RELEASE_URI}
	!truetype? (
		mirror://mplayer/releases/fonts/font-arial-iso-8859-1.tar.bz2
		mirror://mplayer/releases/fonts/font-arial-iso-8859-2.tar.bz2
		mirror://mplayer/releases/fonts/font-arial-cp1250.tar.bz2
	)
"

LICENSE="GPL-3"
SLOT="0"
if [[ ${PV} == *9999* ]]; then
	KEYWORDS=""
else
	KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~amd64-linux"
fi
IUSE="3dnow 3dnowext +a52 aalib +alsa altivec aqua bidi bl
bluray bs2b cddb +cdio cdparanoia cpudetection custom-cpuopts
debug directfb doc +dts +dv dvb +dvd +dvdnav dxr3 +enca +faad fbcon ftp
gif ggi +iconv ipv6 jack joystick jpeg kernel_linux ladspa +libass libcaca lirc
mad md5sum +mmx mmxext mng +mp3 nas +network nut +opengl oss png pnm pulseaudio
pvr +quicktime radio +rar +real +rtc samba +shm sdl +speex sse sse2 ssse3 tga
+theora +truetype +unicode v4l vdpau +vorbis +X xanim xinerama
+xscreensaver +xv xvid"
IUSE+=" symlink"

VIDEO_CARDS="s3virge mga tdfx vesa"
for x in ${VIDEO_CARDS}; do
	IUSE+=" video_cards_${x}"
done

REQUIRED_USE="
	cdio? ( !cdparanoia )
	cddb? ( || ( cdio cdparanoia ) network )
	dvdnav? ( dvd )
	libass? ( truetype )
	truetype? ( iconv )
	radio? ( || ( dvb v4l ) )
	dxr3? ( X )
	ggi? ( X )
	opengl? ( X )
	vdpau? ( X )
	xinerama? ( X )
	xscreensaver? ( X )
	xv? ( X )
"

FONT_RDEPS="
	virtual/ttf-fonts
	media-libs/fontconfig
	>=media-libs/freetype-2.2.1:2
"
# Rar: althrought -gpl version is nice, it cant do most functions normal rars can
#	nemesi? ( net-libs/libnemesi )
RDEPEND+="
	sys-libs/ncurses
	sys-libs/zlib
	X? (
		x11-libs/libXext
		x11-libs/libXxf86vm
		ggi? (
			media-libs/libggi
			media-libs/libggiwmh
		)
		opengl? ( virtual/opengl )
		vdpau? ( x11-libs/libvdpau )
		xinerama? ( x11-libs/libXinerama )
		xscreensaver? ( x11-libs/libXScrnSaver )
		xv? (
			x11-libs/libXv
		)
	)
	a52? ( media-libs/a52dec )
	aalib? ( media-libs/aalib )
	alsa? ( media-libs/alsa-lib )
	bidi? ( dev-libs/fribidi )
	bluray? ( media-libs/libbluray )
	bs2b? ( media-libs/libbs2b )
	cdio? ( dev-libs/libcdio )
	cdparanoia? ( !cdio? ( media-sound/cdparanoia ) )
	directfb? ( dev-libs/DirectFB )
	dts? ( media-libs/libdca )
	dv? ( media-libs/libdv )
	dvb? ( virtual/linuxtv-dvb-headers )
	dvd? (
		>=media-libs/libdvdread-4.1.3
		dvdnav? ( >=media-libs/libdvdnav-4.1.3 )
	)
	enca? ( app-i18n/enca )
	faad? ( media-libs/faad2 )
	gif? ( media-libs/giflib )
	iconv? ( virtual/libiconv )
	jack? ( media-sound/jack-audio-connection-kit )
	jpeg? ( virtual/jpeg )
	ladspa? ( media-libs/ladspa-sdk )
	libass? ( >=media-libs/libass-0.9.10[enca?,fontconfig] )
	libcaca? ( media-libs/libcaca )
	lirc? ( app-misc/lirc )
	mad? ( media-libs/libmad )
	mng? ( media-libs/libmng )
	mp3? ( media-sound/mpg123 )
	nas? ( media-libs/nas )
	nut? ( >=media-libs/libnut-661 )
	png? ( media-libs/libpng )
	pnm? ( media-libs/netpbm )
	pulseaudio? ( media-sound/pulseaudio )
	rar? (
		|| (
			app-arch/unrar
			app-arch/rar
		)
	)
	samba? ( net-fs/samba )
	sdl? ( media-libs/libsdl )
	speex? ( media-libs/speex )
	theora? ( media-libs/libtheora )
	truetype? ( ${FONT_RDEPS} )
	vorbis? ( media-libs/libvorbis )
	xanim? ( media-video/xanim )
	xvid? ( media-libs/xvid )
	|| ( media-libs/libpostproc <media-video/libav-0.8.2-r1 media-video/ffmpeg )
	>=virtual/ffmpeg-0.10.2
	symlink? ( !media-video/mplayer )
"
ASM_DEP="dev-lang/yasm"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	dev-lang/python
	sys-devel/gettext
	X? (
		x11-proto/videoproto
		x11-proto/xf86vidmodeproto
		dxr3? ( media-video/em8300-libraries )
		xinerama? ( x11-proto/xineramaproto )
		xscreensaver? ( x11-proto/scrnsaverproto )
	)
	amd64? ( ${ASM_DEP} )
	doc? (
		dev-libs/libxslt app-text/docbook-xml-dtd
		app-text/docbook-xsl-stylesheets
	)
	x86? ( ${ASM_DEP} )
	x86-fbsd? ( ${ASM_DEP} )
"

pkg_setup() {
	if [[ ${PV} == *9999* ]]; then
		elog
		elog "This is a live ebuild which installs the latest from upstream's"
		elog "${VCS_ECLASS} repository, and is unsupported by Gentoo."
		elog "Everything but bugs in the ebuild itself will be ignored."
		elog
	fi

	if use cpudetection; then
		ewarn
		ewarn "You've enabled the cpudetection flag. This feature is"
		ewarn "included mainly for people who want to use the same"
		ewarn "binary on another system with a different CPU architecture."
		ewarn "MPlayer will already detect your CPU settings by default at"
		ewarn "buildtime; this flag is used for runtime detection."
		ewarn "You won't need this turned on if you are only building"
		ewarn "mplayer for this system. Also, if your compile fails, try"
		ewarn "disabling this use flag."
	fi

	if use custom-cpuopts; then
		ewarn
		ewarn "You are using the custom-cpuopts flag which will"
		ewarn "specifically allow you to enable / disable certain"
		ewarn "CPU optimizations."
		ewarn
		ewarn "Most desktop users won't need this functionality, but it"
		ewarn "is included for corner cases like cross-compiling and"
		ewarn "certain profiles. If unsure, disable this flag and MPlayer"
		ewarn "will automatically detect and use your available CPU"
		ewarn "optimizations."
		ewarn
		ewarn "Using this flag means your build is unsupported, so"
		ewarn "please make sure your CPU optimization use flags (3dnow"
		ewarn "3dnowext mmx mmxext sse sse2 ssse3) are properly set."
	fi

	einfo "For various format support you need to enable the support on your ffmpeg package:"
	einfo "    media-video/libav or media-video/ffmpeg"
}

src_prepare() {
	# fix path to bash executable in configure scripts
	local bash_scripts="configure version.sh"
	sed -i -e "1c\#!${EPREFIX}/bin/bash" \
		${bash_scripts} || die

	if [[ -n ${NAMESUF} ]]; then
		sed -e "/elif linux ; then/a\  _exesuf=\"${NAMESUF}\"" \
			-i configure || die
		sed -e "\, -m 644 DOCS/man/en/mplayer,i\	mv DOCS/man/en/mplayer.1 DOCS/man/en/${PN}.1" \
			-e "\, -m 644 DOCS/man/\$(lang)/mplayer,i\	mv DOCS/man/\$(lang)/mplayer.1 DOCS/man/\$(lang)/${PN}.1" \
			-e "s/er.1/er${NAMESUF}.1/g" \
			-i Makefile || die
		sed -e "s/mplayer/${PN}/" \
			-i TOOLS/midentify.sh || die
	fi

	base_src_prepare
}

src_configure() {
	local myconf=""
	local uses i

	# set LINGUAS
	[[ -n $LINGUAS ]] && LINGUAS="${LINGUAS/da/dk}"

	# mplayer ebuild uses "use foo || --disable-foo" to forcibly disable
	# compilation in almost every situation. The reason for this is
	# because if --enable is used, it will force the build of that option,
	# regardless of whether the dependency is available or not.

	###################
	#Optional features#
	###################
	# disable svga since we don't want it
	# disable arts since we don't have kde3
	# disable tremor, it needs libvorbisidec and is for FPU-less systems only
	myconf+="
		--disable-svga
		--disable-arts
		--disable-kai
		--disable-tremor
		$(use_enable network networking)
		$(use_enable joystick)
	"
	uses="bl bluray enca ftp libass rtc" # nemesi <- not working with in-tree ebuild
	myconf+=" --disable-nemesi" # nemesi automagic disable
	for i in ${uses}; do
		use ${i} || myconf+=" --disable-${i}"
	done
	use bidi || myconf+=" --disable-fribidi"
	use ipv6 || myconf+=" --disable-inet6"
	use nut || myconf+=" --disable-libnut"
	use rar || myconf+=" --disable-unrarexec"
	use samba || myconf+=" --disable-smb"
	if ! use lirc; then
		myconf+="
			--disable-lirc
			--disable-lircc
			--disable-apple-ir
		"
	fi

	########
	# CDDA #
	########
	use cddb || myconf+=" --disable-cddb"
	use cdio || myconf+=" --disable-libcdio"
	use cdparanoia || myconf+=" --disable-cdparanoia"

	################################
	# DVD read, navigation support #
	################################
	#
	# dvdread - accessing a DVD
	# dvdnav - navigation of menus
	#
	# use external libdvdcss, dvdread and dvdnav
	myconf+=" --disable-dvdread-internal --disable-libdvdcss-internal"
	if use dvd; then
		use dvdnav || myconf+=" --disable-dvdnav"
	else
		myconf+="
			--disable-dvdnav
			--disable-dvdread
		"
	fi

	#############
	# Subtitles #
	#############
	# SRT/ASS/SSA (subtitles) requires freetype support
	# freetype support requires iconv
	# iconv optionally can use unicode
	if ! use truetype; then
		myconf+=" --disable-freetype"
		if ! use iconv; then
			myconf+="
				--disable-iconv
				--charset=noconv
			"
		fi
	fi
	use iconv && use unicode && myconf+=" --charset=UTF-8"

	#####################################
	# DVB / Video4Linux / Radio support #
	#####################################
	myconf+=" --disable-tv-bsdbt848"
	# broken upstream, won't work with recent kernels
	myconf+=" --disable-ivtv"
	# v4l1 is gone since linux-headers-2.6.38
	myconf+=" --disable-tv-v4l1"
	if { use dvb || use v4l || use pvr || use radio; }; then
		use dvb || myconf+=" --disable-dvb"
		use pvr || myconf+=" --disable-pvr"
		use v4l || myconf+=" --disable-tv-v4l2"
		if use radio && { use dvb || use v4l; }; then
			myconf+="
				--enable-radio
				--disable-radio-capture
			"
		else
			myconf+="
				--disable-radio-v4l2
				--disable-radio-bsdbt848
			"
		fi
	else
		myconf+="
			--disable-tv
			--disable-tv-v4l2
			--disable-radio
			--disable-radio-v4l2
			--disable-radio-bsdbt848
			--disable-dvb
			--disable-v4l2
			--disable-pvr"
	fi

	##########
	# Codecs #
	##########
	myconf+=" --disable-musepack" # deprecated, libavcodec Musepack decoder is preferred
	use dts || myconf+=" --disable-libdca"
	use mp3 || myconf+=" --disable-mpg123"
	uses="a52 bs2b dv vorbis"
	for i in ${uses}; do
		use ${i} || myconf+=" --disable-lib${i}"
	done
	uses="faad gif jpeg mad mng png pnm speex tga theora xanim xvid"
	for i in ${uses}; do
		use ${i} || myconf+=" --disable-${i}"
	done
	myconf+=" --disable-live" # >=live-2012 are broken

	#################
	# Binary codecs #
	#################
	# bug 213836
	use quicktime || myconf+=" --disable-qtx"

	######################
	# RealPlayer support #
	######################
	# Realplayer support shows up in four places:
	# - libavcodec (internal)
	# - win32codecs
	# - realcodecs (win32codecs libs)
	# - realcodecs (realplayer libs)

	# internal
	use real || myconf+=" --disable-real"

	# Real binary codec support only available on x86, amd64
	if use real; then
		use x86 && myconf+=" --codecsdir=/opt/RealPlayer/codecs"
		use amd64 && myconf+=" --codecsdir=/usr/$(get_libdir)/codecs"
	fi
	myconf+=" --disable-win32dll"

	################
	# Video Output #
	################
	uses="directfb md5sum sdl"
	for i in ${uses}; do
		use ${i} || myconf+=" --disable-${i}"
	done
	use aalib || myconf+=" --disable-aa"
	use fbcon || myconf+=" --disable-fbdev"
	use fbcon && use video_cards_s3virge && myconf+=" --enable-s3fb"
	use libcaca || myconf+=" --disable-caca"

	if ! use kernel_linux || ! use video_cards_mga; then
		 myconf+=" --disable-mga --disable-xmga"
	fi

	if use video_cards_tdfx; then
		myconf+="
			$(use_enable video_cards_tdfx tdfxvid)
			$(use_enable fbcon tdfxfb)
		"
	else
		myconf+="
			--disable-3dfx
			--disable-tdfxvid
			--disable-tdfxfb
		"
	fi

	# sun card, disable by default, see bug #258729
	myconf+=" --disable-xvr100"

	################
	# Audio Output #
	################
	myconf+=" --disable-rsound" # media-sound/rsound is in pro-audio overlay only
	myconf+=" --disable-esd"
	uses="alsa jack ladspa nas"
	for i in ${uses}; do
		use ${i} || myconf+=" --disable-${i}"
	done
	#use openal && myconf+=" --enable-openal" # build fails
	use pulseaudio || myconf+=" --disable-pulse"
	if ! use radio; then
		use oss || myconf+=" --disable-ossaudio"
	fi

	####################
	# Advanced Options #
	####################
	# Platform specific flags, hardcoded on amd64 (see below)
	use cpudetection && myconf+=" --enable-runtime-cpudetection"

	# Turning off CPU optimizations usually will break the build.
	# However, this use flag, if enabled, will allow users to completely
	# specify which ones to use. If disabled, mplayer will automatically
	# enable all CPU optimizations that the host build supports.
	if use custom-cpuopts; then
		uses="3dnow 3dnowext altivec mmx mmxext shm sse sse2 ssse3"
		for i in ${uses}; do
			myconf+=" $(use_enable ${i})"
		done
	fi

	use debug && myconf+=" --enable-debug=3"

	if use x86 && gcc-specs-pie; then
		filter-flags -fPIC -fPIE
		append-ldflags -nopie
	fi

	is-flag -O? || append-flags -O2

	# workaround bug, x86 just has too few registers, see c.f.
	# http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=402950#44
	# and 32-bits OSX, bug 329861
	if [[ ${CHOST} == i?86-* ]] ; then
		use debug || append-flags -fomit-frame-pointer
	fi

	###########################
	# X enabled configuration #
	###########################
	myconf+=" --disable-dga1 --disable-dga2"
	if use X; then
		uses="dxr3 ggi xinerama xv"
		for i in ${uses}; do
			use ${i} || myconf+=" --disable-${i}"
		done
		use opengl || myconf+=" --disable-gl"
		use vdpau || myconf+=" --disable-vdpau"
		use video_cards_vesa || myconf+=" --disable-vesa"
		use xscreensaver || myconf+=" --disable-xss"
	else
		myconf+="
			--disable-dxr3
			--disable-ggi
			--disable-gl
			--disable-vdpau
			--disable-xinerama
			--disable-xss
			--disable-xv
			--disable-x11
		"
	fi

	############################
	# OSX (aqua) configuration #
	############################
	if use aqua; then
		myconf+="
			--enable-macosx-finder
			--enable-macosx-bundle
		"
	fi

	./configure \
		--cc="$(tc-getCC)" \
		--host-cc="$(tc-getBUILD_CC)" \
		--pkg-config="$(tc-getPKG_CONFIG)" \
		--prefix="${EPREFIX}"/usr \
		--bindir="${EPREFIX}"/usr/bin \
		--libdir="${EPREFIX}"/usr/$(get_libdir) \
		--confdir="${EPREFIX}"/etc/${PN} \
		--datadir="${EPREFIX}"/usr/share/${PN} \
		--mandir="${EPREFIX}"/usr/share/man \
		--localedir="${EPREFIX}"/usr/share/locale \
		--enable-translation \
		${myconf} || die
}

src_compile() {
	# enable verbose build, bug #448196
	base_src_compile V=1
	# Build only user-requested docs if they're available.
	if use doc ; then
		# select available languages from $LINGUAS
		LINGUAS=${LINGUAS/zh/zh_CN}
		local ALLOWED_LINGUAS="cs de en es fr hu it pl ru zh_CN"
		local BUILT_DOCS=""
		for i in ${LINGUAS} ; do
			has ${i} ${ALLOWED_LINGUAS} && BUILT_DOCS+=" ${i}"
		done
		if [[ -z $BUILT_DOCS ]]; then
			emake -j1 -C DOCS/xml html-chunked
		else
			for i in ${BUILT_DOCS}; do
				emake -j1 -C DOCS/xml html-chunked-${i}
			done
		fi
	fi
}

src_install() {
	local i

	emake \
		DESTDIR="${D}" \
		INSTALLSTRIP="" \
		install

	dodoc AUTHORS Copyright README etc/codecs.conf

	docinto tech/
	dodoc DOCS/tech/{*.txt,mpsub.sub,playtree}
	docinto TOOLS/
	dodoc -r TOOLS
	if use real; then
		docinto tech/realcodecs/
		dodoc DOCS/tech/realcodecs/*
	fi

	if use doc; then
		docinto html/
		dohtml -r "${S}"/DOCS/HTML/*
	fi

	if ! use truetype; then
		dodir /usr/share/${PN}/fonts
		# Do this generic, as the mplayer people like to change the structure
		# of their zips ...
		for i in $(find "${WORKDIR}/" -type d -name 'font-arial-*'); do
			cp -pPR "${i}" "${ED}/usr/share/${PN}/fonts"
		done
		# Fix the font symlink ...
		rm -rf "${ED}/usr/share/${PN}/font"
		dosym fonts/font-arial-14-iso-8859-1 /usr/share/${PN}/font
	fi

	insinto /etc/${PN}
	newins "${S}/etc/example.conf" mplayer.conf
	cat >> "${ED}/etc/${PN}/mplayer.conf" << _EOF_
# Config options can be section specific, global
# options should go in the default section
[default]
_EOF_
	doins "${S}/etc/input.conf"

	# set unrar path when required
	if use rar; then
		cat >> "${ED}/etc/${PN}/mplayer.conf" << _EOF_
unrarexec=${EPREFIX}/usr/bin/unrar
_EOF_
	fi
	dosym ../../../etc/${PN}/mplayer.conf /usr/share/${PN}/mplayer.conf

	newbin "${S}/TOOLS/midentify.sh" midentify${NAMESUF}

	if [[ -n ${NAMESUF} ]] && use symlink; then
		dosym "${PN}" /usr/bin/mplayer
		dosym "midentify${NAMESUF}" /usr/bin/midentify
	fi
}
