# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mplayer/mplayer-1.0_rc4_p20110322-r1.ebuild,v 1.12 2012/06/17 05:19:59 yngwin Exp $

EAPI=4

EGIT_REPO_URI="git://git.libav.org/libav.git"
EGIT_PROJECT="ffmpeg"
ESVN_REPO_URI="svn://svn.mplayerhq.hu/mplayer/trunk"
[[ ${PV} = *9999* ]] && SVN_ECLASS="subversion git" || SVN_ECLASS=""

inherit toolchain-funcs eutils flag-o-matic multilib base ${SVN_ECLASS}

# BUMP ME PLZ, NO COOKIES OTHERWISE
[[ ${PV} != *9999* ]] && MPLAYER_REVISION=SVN-r33094

IUSE="3dnow 3dnowext +a52 aalib +alsa altivec aqua bidi bindist bl bluray
bs2b cddb +cdio cdparanoia cpudetection custom-cpuopts debug dga +dirac
directfb doc +dts +dv dvb +dvd +dvdnav dxr3 +enca +encode +faac +faad fbcon
ftp gif ggi gsm +iconv ipv6 jack joystick jpeg jpeg2k kernel_linux ladspa
+libass libcaca libmpeg2 lirc +live lzo mad md5sum +mmx mmxext mng +mp3 mpg123
nas +network nut openal amr +opengl +osdmenu oss png pnm pulseaudio pvr
+quicktime radio +rar +real +rtc rtmp samba +shm +schroedinger sdl +speex
sse sse2 ssse3 tga +theora +tremor +truetype +toolame +twolame +unicode
v4l vdpau vidix +vorbis vpx win32codecs +X +x264 xanim xinerama +xscreensaver
+xv +xvid xvmc zoran"
[[ ${PV} == *9999* ]] && IUSE+=" external-ffmpeg"

VIDEO_CARDS="s3virge mga tdfx vesa"
for x in ${VIDEO_CARDS}; do
	IUSE+=" video_cards_${x}"
done

FONT_URI="
	mirror://mplayer/releases/fonts/font-arial-iso-8859-1.tar.bz2
	mirror://mplayer/releases/fonts/font-arial-iso-8859-2.tar.bz2
	mirror://mplayer/releases/fonts/font-arial-cp1250.tar.bz2
"
if [[ ${PV} == *9999* ]]; then
	RELEASE_URI=""
else
	RELEASE_URI="http://dev.gentoo.org/~scarabeus/${P}.tar.xz
		mirror://gentoo/${P}.tar.xz"
fi
SRC_URI="${RELEASE_URI}
	!truetype? ( ${FONT_URI} )"

DESCRIPTION="Media Player for Linux"
HOMEPAGE="http://www.mplayerhq.hu/"

FONT_RDEPS="
	virtual/ttf-fonts
	media-libs/fontconfig
	>=media-libs/freetype-2.2.1:2
"
X_RDEPS="
	x11-libs/libXext
	x11-libs/libXxf86vm
"
[[ ${PV} == *9999* ]] && RDEPEND+=" external-ffmpeg? ( media-video/ffmpeg )"
# Rar: althrought -gpl version is nice, it cant do most functions normal rars can
#	nemesi? ( net-libs/libnemesi )
RDEPEND+="
	sys-libs/ncurses
	app-arch/bzip2
	sys-libs/zlib
	!bindist? (
		x86? (
			win32codecs? ( media-libs/win32codecs )
		)
	)
	X? (
		${X_RDEPS}
		dga? ( x11-libs/libXxf86dga )
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
			xvmc? ( x11-libs/libXvMC )
		)
	)
	a52? ( media-libs/a52dec )
	aalib? ( media-libs/aalib )
	alsa? ( media-libs/alsa-lib )
	amr? ( !bindist? ( media-libs/opencore-amr ) )
	bidi? ( dev-libs/fribidi )
	bluray? ( media-libs/libbluray )
	bs2b? ( media-libs/libbs2b )
	cdio? ( dev-libs/libcdio )
	cdparanoia? ( !cdio? ( media-sound/cdparanoia ) )
	dirac? ( media-video/dirac )
	directfb? ( dev-libs/DirectFB )
	dts? ( media-libs/libdca )
	dv? ( media-libs/libdv )
	dvb? ( virtual/linuxtv-dvb-headers )
	dvd? (
		>=media-libs/libdvdread-4.1.3
		dvdnav? ( >=media-libs/libdvdnav-4.1.3 )
	)
	encode? (
		!twolame? ( toolame? ( media-sound/toolame ) )
		twolame? ( media-sound/twolame )
		faac? ( !bindist? ( media-libs/faac ) )
		mp3? ( media-sound/lame )
		x264? ( >=media-libs/x264-0.0.20100423 )
		xvid? ( media-libs/xvid )
	)
	enca? ( app-i18n/enca )
	faad? ( media-libs/faad2 )
	gif? ( media-libs/giflib )
	gsm? ( media-sound/gsm )
	iconv? ( virtual/libiconv )
	jack? ( media-sound/jack-audio-connection-kit )
	jpeg? ( virtual/jpeg )
	jpeg2k? ( media-libs/openjpeg )
	ladspa? ( media-libs/ladspa-sdk )
	libass? ( ${FONT_RDEPS} >=media-libs/libass-0.9.10[enca?] )
	libcaca? ( media-libs/libcaca )
	libmpeg2? ( media-libs/libmpeg2 )
	lirc? ( app-misc/lirc )
	live? ( media-plugins/live )
	lzo? ( >=dev-libs/lzo-2 )
	mad? ( media-libs/libmad )
	mng? ( media-libs/libmng )
	mpg123? ( media-sound/mpg123 )
	nas? ( media-libs/nas )
	nut? ( >=media-libs/libnut-661 )
	openal? ( media-libs/openal )
	png? ( media-libs/libpng )
	pnm? ( media-libs/netpbm )
	pulseaudio? ( media-sound/pulseaudio )
	rar? (
		|| (
			app-arch/unrar
			app-arch/rar
		)
	)
	rtmp? ( media-video/rtmpdump )
	samba? ( net-fs/samba )
	schroedinger? ( media-libs/schroedinger )
	sdl? ( media-libs/libsdl )
	speex? ( media-libs/speex )
	theora? ( media-libs/libtheora[encode?] )
	truetype? ( ${FONT_RDEPS} )
	vorbis? ( media-libs/libvorbis )
	vpx? ( media-libs/libvpx )
	xanim? ( media-video/xanim )
"

X_DEPS="
	x11-proto/videoproto
	x11-proto/xf86vidmodeproto
"
ASM_DEP="dev-lang/yasm"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	X? (
		${X_DEPS}
		dga? ( x11-proto/xf86dgaproto )
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

SLOT="0"
LICENSE="GPL-2"
if [[ ${PV} != *9999* ]]; then
	KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
else
	KEYWORDS=""
fi

# bindist does not cope with amr codecs (#299405#c6), faac codecs are nonfree, win32codecs are nonfree
# libcdio support: prefer libcdio over cdparanoia and don't check for cddb w/cdio
# dvd navigation requires dvd read support
# ass and freetype font require iconv and ass requires freetype fonts
# unicode transformations are usefull only with iconv
# libvorbis require external tremor to work
# radio requires oss or alsa backend
# xvmc requires xvideo support
REQUIRED_USE="bindist? ( !amr !faac !win32codecs )"

PATCHES=(
	"${FILESDIR}"/${P}-gcc46.patch
	"${FILESDIR}"/${P}-sami_subtitle_parsing.patch
)

pkg_setup() {
	if [[ ${PV} == *9999* ]]; then
		elog
		elog "This is a live ebuild which installs the latest from upstream's"
		elog "subversion repository, and is unsupported by Gentoo."
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
}

src_unpack() {
	if [[ ${PV} = *9999* ]]; then
		subversion_src_unpack
		cd "${WORKDIR}"
		rm -rf "${WORKDIR}/${P}/ffmpeg/"
		( S="${WORKDIR}/${P}/ffmpeg/" git_src_unpack )
	else
		unpack ${A}
	fi

	if ! use truetype; then
		unpack font-arial-iso-8859-1.tar.bz2 \
			font-arial-iso-8859-2.tar.bz2 \
			font-arial-cp1250.tar.bz2
	fi
}

src_prepare() {
	if [[ ${PV} = *9999* ]]; then
		# Set SVN version manually
		subversion_wc_info
		sed -i -e "s/UNKNOWN/${ESVN_WC_REVISION}/" "${S}/version.sh" || die
	else
		# Set version #
		sed -i -e "s/UNKNOWN/${MPLAYER_REVISION}/" "${S}/version.sh" || die
	fi

	# fix path to bash executable in configure scripts
	sed -i -e "1c\#!${EPREFIX}/bin/bash" configure version.sh || die

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
	# always disable internal ass
	myconf+="
		--disable-svga --disable-svgalib_helper
		--disable-ass-internal
		--disable-arts
		--disable-kai
		$(use_enable network networking)
		$(use_enable joystick)
	"
	uses="bl bluray enca ftp rtc" # nemesi <- not working with in-tree ebuild
	myconf+=" --disable-nemesi" # nemesi automagic disable
	for i in ${uses}; do
		use ${i} || myconf+=" --disable-${i}"
	done
	use bidi || myconf+=" --disable-fribidi"
	use ipv6 || myconf+=" --disable-inet6"
	use libass || myconf+=" --disable-ass"
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

	# libcdio support: prefer libcdio over cdparanoia
	# don't check for cddb w/cdio
	if use cdio; then
		myconf+=" --disable-cdparanoia"
	else
		myconf+=" --disable-libcdio"
		use cdparanoia || myconf+=" --disable-cdparanoia"
		use cddb || myconf+=" --disable-cddb"
	fi

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
	#
	# SRT/ASS/SSA (subtitles) requires freetype support
	# freetype support requires iconv
	# iconv optionally can use unicode
	if ! use libass && ! use truetype; then
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
	# gone since linux-headers-2.6.38
	myconf+=" --disable-tv-v4l1"
	if { use dvb || use v4l || use pvr || use radio; }; then
		use dvb || myconf+=" --disable-dvb"
		use pvr || myconf+=" --disable-pvr"
		use v4l || myconf+=" --disable-tv-v4l2"
		if use radio && { use dvb || use v4l; }; then
			myconf+="
				--enable-radio
				$(use_enable encode radio-capture)
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
	myconf+=" --disable-musepack" # Use internal musepack codecs for SV7 and SV8 support
	myconf+=" --disable-libmpeg2-internal" # always use system media-libs/libmpeg2
	use dirac || myconf+=" --disable-libdirac-lavc"
	use dts || myconf+=" --disable-libdca"
	if ! use mp3; then
		myconf+="
			--disable-mp3lame
			--disable-mp3lame-lavc
			--disable-mp3lib
		"
	fi
	uses="a52 bs2b dv gsm lzo rtmp"
	for i in ${uses}; do
		use ${i} || myconf+=" --disable-lib${i}"
	done
	use schroedinger || myconf+=" --disable-libschroedinger-lavc"
	use amr || myconf+=" --disable-libopencore_amrnb --disable-libopencore_amrwb"

	uses="faad gif jpeg libmpeg2 live mad mng mpg123 png pnm speex tga theora xanim"
	for i in ${uses}; do
		use ${i} || myconf+=" --disable-${i}"
	done
	use jpeg2k || myconf+=" --disable-libopenjpeg"
	if use vorbis || use tremor; then
		use tremor || myconf+=" --disable-tremor-internal"
		use vorbis || myconf+=" --disable-libvorbis"
	else
		myconf+="
			--disable-tremor-internal
			--disable-tremor
			--disable-libvorbis
		"
	fi
	use vpx || myconf+=" --disable-libvpx-lavc"
	# Encoding
	uses="faac x264 xvid toolame twolame"
	if use encode; then
		for i in ${uses}; do
			use ${i} || myconf+=" --disable-${i}"
		done
		use faac || myconf+=" --disable-faac-lavc"
		if use bindist && use faac; then
			ewarn "faac is nonfree and cannot be distributed; disabling faac support."
			myconf+=" --disable-faac --disable-faac-lavc"
		fi
	else
		myconf+=" --disable-mencoder"
		myconf+=" --disable-faac-lavc"
		for i in ${uses}; do
			myconf+=" --disable-${i}"
			use ${i} && elog "Useflag \"${i}\" require \"encode\" useflag enabled to work."
		done
	fi

	#################
	# Binary codecs #
	#################
	# bug 213836
	if ! use x86 || ! use win32codecs; then
		use quicktime || myconf+=" --disable-qtx"
	fi

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
	myconf+=" $(use_enable win32codecs win32dll)"

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
	use zoran || myconf+=" --disable-zr"

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
	myconf+=" --disable-esd"
	uses="alsa jack ladspa nas openal"
	for i in ${uses}; do
		use ${i} || myconf+=" --disable-${i}"
	done
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
	myconf+=" --disable-gui"
	if use X; then
		uses="dxr3 ggi xinerama"
		for i in ${uses}; do
			use ${i} || myconf+=" --disable-${i}"
		done
		use dga || myconf+=" --disable-dga1 --disable-dga2"
		use opengl || myconf+=" --disable-gl"
		use osdmenu && myconf+=" --enable-menu"
		use vdpau || myconf+=" --disable-vdpau"
		use video_cards_vesa || myconf+=" --disable-vesa"
		use vidix || myconf+=" --disable-vidix --disable-vidix-pcidb"
		use xscreensaver || myconf+=" --disable-xss"

		if use xv; then
			if use xvmc; then
				myconf+=" --enable-xvmc --with-xvmclib=XvMCW"
			else
				myconf+=" --disable-xvmc"
			fi
		else
			myconf+="
				--disable-xv
				--disable-xvmc
			"
			use xvmc && elog "Disabling xvmc because it requires \"xv\" useflag enabled."
		fi
	else
		myconf+="
			--disable-dga1
			--disable-dga2
			--disable-dxr3
			--disable-ggi
			--disable-gl
			--disable-vdpau
			--disable-vidix
			--disable-vidix-pcidb
			--disable-xinerama
			--disable-xss
			--disable-xv
			--disable-xvmc
			--disable-x11
		"
		uses="dga dxr3 ggi opengl osdmenu vdpau vidix xinerama xscreensaver xv"
		for i in ${uses}; do
			use ${i} && elog "Useflag \"${i}\" require \"X\" useflag enabled to work."
		done
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

	###################
	# External FFmpeg #
	###################
	if [[ ${PV} == *9999* ]]; then
		use external-ffmpeg && myconf+=" --disable-ffmpeg_a"
	fi

	myconf="--cc=$(tc-getCC)
		--host-cc=$(tc-getBUILD_CC)
		--prefix=${EPREFIX}/usr
		--bindir=${EPREFIX}/usr/bin
		--libdir=${EPREFIX}/usr/$(get_libdir)
		--confdir=${EPREFIX}/etc/mplayer
		--datadir=${EPREFIX}/usr/share/mplayer${namesuf}
		--mandir=${EPREFIX}/usr/share/man
		${myconf}"

	CFLAGS="${CFLAGS}" ./configure ${myconf} || die
}

src_compile() {
	base_src_compile
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

	dodoc AUTHORS Changelog Copyright README etc/codecs.conf

	docinto tech/
	dodoc DOCS/tech/{*.txt,MAINTAINERS,mpsub.sub,playtree,TODO,wishlist}
	docinto TOOLS/
	dodoc -r TOOLS
	if use real; then
		docinto tech/realcodecs/
		dodoc DOCS/tech/realcodecs/*
	fi
	docinto tech/mirrors/
	dodoc DOCS/tech/mirrors/*

	if use doc; then
		docinto html/
		dohtml -r "${S}"/DOCS/HTML/*
	fi

	if ! use libass && ! use truetype; then
		dodir /usr/share/mplayer/fonts
		# Do this generic, as the mplayer people like to change the structure
		# of their zips ...
		for i in $(find "${WORKDIR}/" -type d -name 'font-arial-*'); do
			cp -pPR "${i}" "${ED}/usr/share/mplayer/fonts"
		done
		# Fix the font symlink ...
		rm -rf "${ED}/usr/share/mplayer/font"
		dosym fonts/font-arial-14-iso-8859-1 /usr/share/mplayer/font
	fi

	insinto /etc/mplayer
	newins "${S}/etc/example.conf" mplayer.conf
	cat >> "${ED}/etc/mplayer/mplayer.conf" << _EOF_
# Config options can be section specific, global
# options should go in the default section
[default]
_EOF_
	doins "${S}/etc/input.conf"
	if use osdmenu; then
		doins "${S}/etc/menu.conf"
	fi

	if use libass || use truetype; then
		cat >> "${ED}/etc/mplayer/mplayer.conf" << _EOF_
fontconfig=1
subfont-osd-scale=4
subfont-text-scale=3
_EOF_
	fi

	# bug 256203
	if use rar; then
		cat >> "${ED}/etc/mplayer/mplayer.conf" << _EOF_
unrarexec=${EPREFIX}/usr/bin/unrar
_EOF_
	fi

	dosym ../../../etc/mplayer/mplayer.conf /usr/share/mplayer/mplayer.conf
	newbin "${S}/TOOLS/midentify.sh" midentify
}

pkg_preinst() {
	[[ -d ${EROOT}/usr/share/mplayer/Skin/default ]] && \
		rm -rf "${EROOT}/usr/share/mplayer/Skin/default"
}

pkg_postrm() {
	# Cleanup stale symlinks
	[ -L "${EROOT}/usr/share/mplayer/font" -a \
			! -e "${EROOT}/usr/share/mplayer/font" ] && \
		rm -f "${EROOT}/usr/share/mplayer/font"

	[ -L "${EROOT}/usr/share/mplayer/subfont.ttf" -a \
			! -e "${EROOT}/usr/share/mplayer/subfont.ttf" ] && \
		rm -f "${EROOT}/usr/share/mplayer/subfont.ttf"
}
