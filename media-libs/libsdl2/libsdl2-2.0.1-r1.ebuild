# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libsdl2/libsdl2-2.0.1-r1.ebuild,v 1.4 2014/04/05 15:59:09 hasufell Exp $

EAPI=5
inherit autotools flag-o-matic toolchain-funcs eutils

MY_P=SDL2-${PV}
DESCRIPTION="Simple Direct Media Layer"
HOMEPAGE="http://www.libsdl.org"
SRC_URI="http://www.libsdl.org/release/${MY_P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="3dnow alsa altivec +audio custom-cflags dbus fusionsound gles haptic +joystick mmx nas opengl oss pulseaudio sse sse2 static-libs +threads tslib udev +video X xinerama xscreensaver"
REQUIRED_USE="
	alsa? ( audio )
	fusionsound? ( audio )
	gles? ( video )
	nas? ( audio )
	opengl? ( video )
	pulseaudio? ( audio )
	xinerama? ( X )
	xscreensaver? ( X )"

RDEPEND="
	alsa? ( media-libs/alsa-lib )
	dbus? ( sys-apps/dbus )
	fusionsound? ( || ( >=media-libs/FusionSound-1.1.1 >=dev-libs/DirectFB-1.7.1[fusionsound] ) )
	gles? ( media-libs/mesa[gles2] )
	nas? ( media-libs/nas )
	opengl? ( virtual/opengl virtual/glu )
	pulseaudio? ( media-sound/pulseaudio )
	tslib? ( x11-libs/tslib )
	udev? ( virtual/udev )
	X? (
		x11-libs/libX11
		x11-libs/libXcursor
		x11-libs/libXext
		x11-libs/libXi
		x11-libs/libXrandr
		x11-libs/libXt
		x11-libs/libXxf86vm
		xinerama? ( x11-libs/libXinerama )
		xscreensaver? ( x11-libs/libXScrnSaver )
	)"
DEPEND="${RDEPEND}
	X? (
		x11-proto/xextproto
		x11-proto/xproto
	)
	virtual/pkgconfig"

S=${WORKDIR}/${MY_P}

src_prepare() {
	# https://bugzilla.libsdl.org/show_bug.cgi?id=1431
	epatch "${FILESDIR}"/${P}-static-libs.patch
	AT_M4DIR="/usr/share/aclocal acinclude" eautoreconf
}

src_configure() {
	use custom-cflags || strip-flags

	# sorted by `./configure --help`
	econf \
		$(use_enable static-libs static) \
		$(use_enable audio) \
		$(use_enable video) \
		--enable-render \
		--enable-events \
		$(use_enable joystick) \
		$(use_enable haptic) \
		--enable-power \
		$(use_enable threads) \
		--enable-timers \
		--enable-file \
		--disable-loadso \
		--enable-cpuinfo \
		--enable-atomic \
		--enable-assembly \
		$(use_enable sse ssemath) \
		$(use_enable mmx) \
		$(use_enable 3dnow) \
		$(use_enable sse) \
		$(use_enable sse2) \
		$(use_enable altivec) \
		$(use_enable oss) \
		$(use_enable alsa) \
		--disable-alsa-shared \
		--disable-esd \
		$(use_enable pulseaudio) \
		--disable-pulseaudio-shared \
		--disable-arts \
		$(use_enable nas) \
		--disable-nas-shared \
		--disable-sndio \
		--disable-sndio-shared \
		$(use_enable audio diskaudio) \
		$(use_enable audio dummyaudio) \
		$(use_enable X video-x11) \
		--disable-x11-shared \
		$(use_enable X video-x11-xcursor) \
		$(use_enable xinerama video-x11-xinerama) \
		$(use_enable X video-x11-xinput) \
		$(use_enable X video-x11-xrandr) \
		$(use_enable xscreensaver video-x11-scrnsaver) \
		$(use_enable X video-x11-xshape) \
		$(use_enable X video-x11-vm) \
		--disable-video-cocoa \
		--disable-video-directfb \
		$(use_enable fusionsound) \
		--disable-fusionsound-shared \
		$(use_enable video video-dummy) \
		$(use_enable opengl video-opengl) \
		$(use_enable gles video-opengles) \
		$(use_enable udev libudev) \
		$(use_enable dbus) \
		$(use_enable tslib input-tslib) \
		--disable-directx \
		--disable-rpath \
		--disable-render-d3d \
		$(use_with X x)
}

src_install() {
	emake DESTDIR="${D}" install
	prune_libtool_files
	dodoc {BUGS,CREDITS,README,README-SDL,README-hg,TODO,WhatsNew}.txt
}
