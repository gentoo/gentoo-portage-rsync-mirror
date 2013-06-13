# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/gpac/gpac-0.5.0.ebuild,v 1.3 2013/06/13 12:42:25 xmw Exp $

EAPI=4

inherit eutils wxwidgets flag-o-matic multilib toolchain-funcs

DESCRIPTION="GPAC is an implementation of the MPEG-4 Systems standard developed from scratch in ANSI C."
HOMEPAGE="http://gpac.wp.mines-telecom.fr/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="a52 aac alsa debug dvb ffmpeg ipv6 jack jpeg jpeg2k mad opengl oss png pulseaudio sdl ssl static-libs theora truetype vorbis wxwidgets xml xvid"

S="${WORKDIR}"/${PN}

RDEPEND="
	a52? ( media-libs/a52dec )
	aac? ( >=media-libs/faad2-2.0 )
	alsa? ( media-libs/alsa-lib )
	dvb? ( media-tv/linuxtv-dvb-apps )
	ffmpeg? ( virtual/ffmpeg )
	jack? ( media-sound/jack-audio-connection-kit )
	jpeg? ( virtual/jpeg )
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
	jpeg2k? ( media-libs/openjpeg:0 )
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

src_prepare() {
	epatch	"${FILESDIR}"/110_all_implicitdecls.patch \
		"${FILESDIR}"/160_all_externalamr.patch \
		"${FILESDIR}"/210_all_system_libogg.patch \
		"${FILESDIR}"/${P}-build-fixes.patch

	# remove last of internal ogg
	sed -i \
		-e 's:<gpac/internal/ogg.h>:<ogg/ogg.h>:' \
		src/media_tools/{av_parsers,gpac_ogg,media_import,media_export}.c || die
	rm -f include/gpac/internal/ogg.h || die

	chmod +x configure

	# make sure configure looks for wx without needing eselect set
	if use wxwidgets; then
		WX_GTK_VER=2.8
		need-wxwidgets unicode
		sed -i -e "s:wx-config:${WX_CONFIG}:g" configure || die
	else
		sed -i -e "s:wx-config:wx-config-doesnotexist:g" configure || die
	fi

	# remove default rule for building objects from code, so that
	# default make rules apply (fixes -fPIC issues)
	sed -i -e '/^\%\.o: \%\.c/{N;d;}' \
		src/Makefile modules/*/Makefile ||die

	# use this to cut down on the warnings noise
	#append-flags -fno-strict-aliasing
}

src_configure() {
	myconf="${myconf} --use-ogg=system"
	if use vorbis; then
		myconf="${myconf} --use-vorbis=system"
	fi
	if use theora; then
		myconf="${myconf} --use-theora=system"
	fi

	tc-export CC CXX AR RANLIB

	econf \
		--enable-svg \
		--enable-pic \
		--disable-amr \
		--use-js=no \
		$(use_enable debug) \
		$(use_enable opengl) \
		$(use_enable oss oss-audio) \
		$(use_enable ssl) \
		$(use_enable ipv6) \
		$(use_enable jack jack yes) \
		$(use_enable pulseaudio pulseaudio yes) \
		$(use_enable alsa) \
		$(use_enable sdl) \
		$(use_enable wxwidgets wx) \
		$(use_enable static-libs static-lib) \
		$(my_use ffmpeg) \
		$(my_use aac faad) \
		$(my_use dvb dvbx) \
		$(my_use jpeg) \
		$(my_use mad) \
		$(my_use png) \
		$(my_use truetype ft) \
		$(my_use xvid) \
		$(my_use jpeg2k openjpeg) \
		$(my_use a52) \
		--cc="$(tc-getCC)" \
		--libdir="/$(get_libdir)" \
		${myconf}

	#temporary build fix
	cp config.h include/gpac/
}

src_compile() {
#	#emake OPTFLAGS="${CFLAGS} -fPIC"
#	LD="$(tc-getCC)" \
	emake OPTFLAGS="${CFLAGS}"
}

src_install() {
	emake STRIP="true" OPTFLAGS="${CFLAGS}" DESTDIR="${D}" install
	emake STRIP="true" OPTFLAGS="${CFLAGS}" DESTDIR="${D}" install-lib
	dodoc AUTHORS BUGS Changelog README TODO INSTALLME
	dodoc doc/*.txt
	dohtml doc/*.html
}
