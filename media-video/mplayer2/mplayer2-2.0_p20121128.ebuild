# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mplayer2/mplayer2-2.0_p20121128.ebuild,v 1.3 2013/01/16 16:39:28 ssuominen Exp $

EAPI=4

[[ ${PV} = *9999* ]] && VCS_ECLASS="git-2" || VCS_ECLASS=""

inherit python toolchain-funcs eutils flag-o-matic multilib base ${VCS_ECLASS}

NAMESUF="${PN/mplayer/}"
DESCRIPTION="Media Player for Linux"
HOMEPAGE="http://www.mplayer2.org/"

if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI="git://git.mplayer2.org/mplayer2.git"
else
	SRC_URI="http://rion-overlay.googlecode.com/files/${P}.tar.xz"
fi

LICENSE="GPL-3"
SLOT="0"
if [[ ${PV} == *9999* ]]; then
	KEYWORDS=""
else
	KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux"
fi
IUSE="+a52 +alsa aqua bindist bluray bs2b cddb +cdio cpudetection debug
directfb doc +dts +dv dvb +dvd +dvdnav +enca +faad fbcon ftp gif +iconv
ipv6 jack joystick jpeg kernel_linux ladspa lcms +libass libcaca lirc mad
md5sum mng +mp3 +network nut +opengl oss png pnm portaudio +postproc
pulseaudio pvr +quicktime quvi radio +rar +real +rtc samba sdl +speex tga
+theora +unicode v4l vcd vdpau +vorbis win32codecs +X xanim xinerama
+xscreensaver +xv xvid yuv4mpeg
"
IUSE+=" symlink"

CPU_FEATURES="3dnow 3dnowext altivec +mmx mmxext +shm sse sse2 ssse3"
for x in ${CPU_FEATURES}; do
	IUSE+=" ${x}"
done

# bindist does not cope with win32codecs, which are nonfree
REQUIRED_USE="
	bindist? ( !win32codecs )
	cddb? ( cdio network )
	dvdnav? ( dvd )
	lcms? ( opengl )
	libass? ( iconv )
	opengl? ( || ( aqua X ) )
	radio? ( || ( dvb v4l ) )
	vdpau? ( X )
	xinerama? ( X )
	xscreensaver? ( X )
	xv? ( X )
"

# Rar: althrought -gpl version is nice, it cant do most functions normal rars can
RDEPEND+="
	sys-libs/ncurses
	sys-libs/zlib
	!bindist? (
		x86? (
			win32codecs? ( media-libs/win32codecs )
		)
	)
	X? (
		x11-libs/libXext
		x11-libs/libXxf86vm
		opengl? ( virtual/opengl )
		lcms? ( media-libs/lcms:2 )
		vdpau? ( x11-libs/libvdpau )
		xinerama? ( x11-libs/libXinerama )
		xscreensaver? ( x11-libs/libXScrnSaver )
		xv? (
			x11-libs/libXv
		)
	)
	a52? ( media-libs/a52dec )
	alsa? ( media-libs/alsa-lib )
	bluray? ( media-libs/libbluray )
	bs2b? ( media-libs/libbs2b )
	cdio? (
		>=dev-libs/libcdio-0.90
		>=dev-libs/libcdio-paranoia-0.90
	)
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
	libass? ( >=media-libs/libass-0.9.10[enca?,fontconfig] virtual/ttf-fonts )
	libcaca? ( media-libs/libcaca )
	lirc? ( app-misc/lirc )
	mad? ( media-libs/libmad )
	mng? ( media-libs/libmng )
	mp3? ( media-sound/mpg123 )
	nut? ( >=media-libs/libnut-661 )
	png? ( media-libs/libpng )
	pnm? ( media-libs/netpbm )
	portaudio? ( >=media-libs/portaudio-19_pre20111121 )
	postproc? ( || ( media-libs/libpostproc <media-video/libav-0.8.2-r1 media-video/ffmpeg ) )
	pulseaudio? ( media-sound/pulseaudio )
	quvi? ( >=media-libs/libquvi-0.4.1 )
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
	vorbis? ( media-libs/libvorbis )
	xanim? ( media-video/xanim )
	xvid? ( media-libs/xvid )
	>=virtual/ffmpeg-0.10.2
	symlink? ( !media-video/mplayer )
"
ASM_DEP="dev-lang/yasm"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=dev-lang/python-2.7
	dev-python/docutils
	sys-devel/gettext
	X? (
		x11-proto/videoproto
		x11-proto/xf86vidmodeproto
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

PATCHES=(
	"${FILESDIR}/${PN}-py2compat.patch"
	"${FILESDIR}/${P}-cdio-api-fixes.patch"
)

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

	if use !libass; then
		ewarn
		ewarn "You've disabled the libass flag. No OSD or subtitles will be displayed."
	fi

	einfo "For various format support you need to enable the support on your ffmpeg package:"
	einfo "    media-video/libav or media-video/ffmpeg"

	# https://bugs.gentoo.org/show_bug.cgi?id=434356#c4
	python_pkg_setup
	major=$(python_get_version --major)
	minor=$(python_get_version --minor)
	[[ ( ${major} -eq 2 && ${minor} -ge 7 ) || ${major} -ge 3 ]] \
			|| die "Please eselect Python 2.7 or later"
}

src_prepare() {
	# fix path to bash executable in configure scripts
	local bash_scripts="configure version.sh"
	sed -i -e "1c\#!${EPREFIX}/bin/bash" \
		${bash_scripts} || die

	if [[ -n ${NAMESUF} ]]; then
		sed -e "/^EXESUF/s,= \$_exesuf$,= ${NAMESUF}\$_exesuf," \
			-i configure || die
		sed -e "s/mplayer/${PN}/" \
			-i TOOLS/midentify.sh || die
	fi

	base_src_prepare
}

src_configure() {
	local myconf=""
	local uses i

	# mplayer ebuild uses "use foo || --disable-foo" to forcibly disable
	# compilation in almost every situation. The reason for this is
	# because if --enable is used, it will force the build of that option,
	# regardless of whether the dependency is available or not.

	###################
	#Optional features#
	###################
	# disable tremor, it needs libvorbisidec and is for FPU-less systems only
	myconf+="
		--disable-tremor
		$(use_enable network networking)
		$(use_enable joystick)
	"
	uses="bluray enca ftp libass rtc vcd"
	for i in ${uses}; do
		use ${i} || myconf+=" --disable-${i}"
	done
	use ipv6 || myconf+=" --disable-inet6"
	use nut || myconf+=" --disable-libnut"
	use quvi || myconf+=" --disable-libquvi"
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

	################################
	# DVD read, navigation support #
	################################
	#
	# dvdread - accessing a DVD
	# dvdnav - navigation of menus
	#
	# use external libdvdcss, dvdread and dvdnav
	myconf+=" --disable-dvdread-internal --disable-libdvdcss-internal"
	use dvd || myconf+=" --disable-dvdread"
	use dvdnav || myconf+=" --disable-dvdnav"

	#############
	# Subtitles #
	#############
	#
	# iconv optionally can use unicode
	use iconv || myconf+=" --disable-iconv --charset=noconv"
	use iconv && use unicode && myconf+=" --charset=UTF-8"

	#####################################
	# DVB / Video4Linux / Radio support #
	#####################################
	myconf+=" --disable-tv-bsdbt848"
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
	uses="directfb md5sum sdl yuv4mpeg"
	for i in ${uses}; do
		use ${i} || myconf+=" --disable-${i}"
	done
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

	for i in ${CPU_FEATURES//+/}; do
		myconf+=" $(use_enable ${i})"
	done

	use debug && myconf+=" --enable-debug=3"

	if use x86 && gcc-specs-pie; then
		filter-flags -fPIC -fPIE
		append-ldflags -nopie
	fi

	###########################
	# X enabled configuration #
	###########################
	use X || myconf+=" --disable-x11"
	uses="vdpau xinerama xv"
	for i in ${uses}; do
		use ${i} || myconf+=" --disable-${i}"
	done
	use opengl || myconf+=" --disable-gl"
	use lcms || myconf+=" --disable-lcms2"
	use xscreensaver || myconf+=" --disable-xss"

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
	use doc && emake -C DOCS/xml html-chunked
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

	if [[ -n ${NAMESUF} ]]; then
		mv "${ED}/usr/share/man/man1/mplayer.1" "${ED}/usr/share/man/man1/mplayer${NAMESUF}.1" || die

		if use symlink; then
			dosym "${PN}" /usr/bin/mplayer
			dosym "midentify${NAMESUF}" /usr/bin/midentify
		fi
	fi
}
