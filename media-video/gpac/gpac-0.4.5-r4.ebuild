# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/gpac/gpac-0.4.5-r4.ebuild,v 1.14 2013/06/13 12:42:25 xmw Exp $

inherit eutils wxwidgets flag-o-matic multilib toolchain-funcs

DESCRIPTION="GPAC is an implementation of the MPEG-4 Systems standard developed from scratch in ANSI C."
HOMEPAGE="http://gpac.sourceforge.net/"
NBV="610"
WBV="600"
PATCHLEVEL="8"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	mirror://gentoo/${P}-patches-${PATCHLEVEL}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="a52 aac alsa debug ffmpeg ipv6 jack jpeg jpeg2k javascript mad opengl oss png pulseaudio sdl ssl theora truetype vorbis wxwidgets xml xvid"

S=${WORKDIR}/${PN}

RDEPEND="
	a52? ( media-libs/a52dec )
	aac? ( >=media-libs/faad2-2.0 )
	alsa? ( media-libs/alsa-lib )
	ffmpeg? ( virtual/ffmpeg )
	jack? ( media-sound/jack-audio-connection-kit )
	jpeg? ( virtual/jpeg )
	javascript? ( >=dev-lang/spidermonkey-1.5 <dev-lang/spidermonkey-1.8.5 )
	mad? ( >=media-libs/libmad-0.15.1b )
	opengl? ( virtual/opengl media-libs/freeglut )
	>=media-libs/libogg-1.1
	png? ( >=media-libs/libpng-1.4 )
	vorbis? ( >=media-libs/libvorbis-1.1 )
	theora? ( media-libs/libtheora )
	truetype? ( >=media-libs/freetype-2.1.4 )
	wxwidgets? ( =x11-libs/wxGTK-2.8* )
	xml? ( >=dev-libs/libxml2-2.6.0 )
	xvid? ( >=media-libs/xvid-1.0.1 )
	sdl? ( media-libs/libsdl )
	jpeg2k? ( <media-libs/openjpeg-2 )
	ssl? ( dev-libs/openssl )
	pulseaudio? ( media-sound/pulseaudio )
	x11-libs/libXt
	x11-libs/libX11
	x11-libs/libXv
	x11-libs/libXext"

DEPEND="${RDEPEND}"

my_use() {
	local flag="$1" pflag="${2:-$1}"
	if use ${flag}; then
		echo "--use-${pflag}=system"
	else
		echo "--use-${pflag}=no"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	EPATCH_SUFFIX="patch" epatch "${WORKDIR}/patches"

	sed -ie '/ldconfig / d' "${S}/Makefile"

	cd "${S}"

	# remove last of internal ogg
	sed -i \
		-e 's:<gpac/internal/ogg.h>:<ogg/ogg.h>:' \
		src/media_tools/{av_parsers,gpac_ogg,media_import,media_export}.c || die
	rm -f include/gpac/internal/ogg.h || die

	chmod +x configure
	# make sure configure looks for wx-2.6
	if use wxwidgets; then
		WX_GTK_VER=2.8
		need-wxwidgets unicode
		sed -i -e "s:wx-config:${WX_CONFIG}:g" configure
	else
		sed -i -e "s:wx-config:false:g" configure
		sed -i -e 's:^has_wx="yes:has_wx="no:' configure
	fi

	use sdl  || sed -i 's:^has_sdl=yes:has_sdl=no:' configure
	use alsa || sed -i 's:^has_alsa="yes":has_alsa=no:' configure

	# make sure mozilla won't be used
	sed -i -e 's/osmozilla//g' applications/Makefile

	# use this to cut down on the warnings noise
	append-flags -fno-strict-aliasing

	# multilib libdir fix
	sed -i -e 's:$(prefix)/lib:$(prefix)/'$(get_libdir)':' Makefile src/Makefile
	sed -i -e 's:/lib/gpac:/'$(get_libdir)'/gpac:' configure

	# --warn-common is linker option, not gcc's one
	sed -i 's/-Wl --warn-common/-Wl,--warn-common/g' configure
}

src_compile() {
	myconf="${myconf} --use-ogg=system"
	if use vorbis; then
		myconf="${myconf} --use-vorbis=system"
	fi
	if use theora; then
		myconf="${myconf} --use-theora=system"
	fi

	tc-export CC CXX

	econf \
		--enable-svg \
		--enable-pic \
		--disable-amr \
		$(use_enable debug) \
		$(use_enable opengl) \
		$(use_enable oss oss-audio) \
		$(use_enable ssl) \
		$(use_enable ipv6) \
		$(use_enable jack)=yes \
		$(use_enable pulseaudio)=yes \
		$(my_use ffmpeg) \
		$(my_use aac faad) \
		$(my_use jpeg) \
		$(my_use mad) \
		$(my_use javascript js) \
		$(my_use png) \
		$(my_use truetype ft) \
		$(my_use xvid) \
		$(my_use jpeg2k openjpeg) \
		$(my_use a52) \
		--cc="$(tc-getCC)" \
		${myconf} || die "configure died"

	emake -j1 OPTFLAGS="${CFLAGS}" || die "emake failed."
}

src_install() {
	emake STRIP="true" OPTFLAGS="${CFLAGS}" DESTDIR="${D}" install || die
	emake STRIP="true" OPTFLAGS="${CFLAGS}" DESTDIR="${D}" install-lib || die
	dodoc AUTHORS BUGS Changelog README TODO
	dodoc doc/*.txt
	dohtml doc/*.html
}
