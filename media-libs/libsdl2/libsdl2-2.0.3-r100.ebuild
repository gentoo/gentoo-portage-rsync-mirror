# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libsdl2/libsdl2-2.0.3-r100.ebuild,v 1.3 2014/08/29 10:15:52 nimiux Exp $

# TODO: convert FusionSound #484250

EAPI=5
inherit autotools flag-o-matic toolchain-funcs eutils

MY_P=SDL2-${PV}
DESCRIPTION="Simple Direct Media Layer"
HOMEPAGE="http://www.libsdl.org"
SRC_URI="http://www.libsdl.org/release/${MY_P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="amd64 x86"

IUSE="3dnow alsa altivec custom-cflags dbus fusionsound gles haptic +joystick mmx nas opengl oss pulseaudio +sound sse sse2 static-libs +threads tslib udev +video wayland X xinerama xscreensaver"
REQUIRED_USE="
	alsa? ( sound )
	fusionsound? ( sound )
	gles? ( video )
	nas? ( sound )
	opengl? ( video )
	pulseaudio? ( sound )
	xinerama? ( X )
	xscreensaver? ( X )"

RDEPEND="
	alsa? ( >=media-libs/alsa-lib-1.0.27.2 )
	dbus? ( >=sys-apps/dbus-1.6.18-r1 )
	fusionsound? ( || ( >=media-libs/FusionSound-1.1.1 >=dev-libs/DirectFB-1.7.1[fusionsound] ) )
	gles? ( >=media-libs/mesa-9.1.6[gles2] )
	nas? ( >=media-libs/nas-1.9.4 )
	opengl? (
		>=virtual/opengl-7.0-r1
		>=virtual/glu-9.0-r1
	)
	pulseaudio? ( >=media-sound/pulseaudio-2.1-r1 )
	tslib? ( >=x11-libs/tslib-1.0-r2 )
	udev? ( >=virtual/libudev-208:= )
	wayland? (
		>=dev-libs/wayland-1.0.6
		>=media-libs/mesa-9.1.6[wayland]
		>=x11-libs/libxkbcommon-0.2.0
	)
	X? (
		>=x11-libs/libX11-1.6.2
		>=x11-libs/libXcursor-1.1.14
		>=x11-libs/libXext-1.3.2
		>=x11-libs/libXi-1.7.2
		>=x11-libs/libXrandr-1.4.2
		>=x11-libs/libXt-1.1.4
		>=x11-libs/libXxf86vm-1.1.3
		xinerama? ( >=x11-libs/libXinerama-1.1.3 )
		xscreensaver? ( >=x11-libs/libXScrnSaver-1.2.2-r1 )
	)"
DEPEND="${RDEPEND}
	X? (
		>=x11-proto/xextproto-7.2.1-r1
		>=x11-proto/xproto-7.0.24
	)
	virtual/pkgconfig"

S=${WORKDIR}/${MY_P}

src_prepare() {
	# https://bugzilla.libsdl.org/show_bug.cgi?id=1431
	epatch "${FILESDIR}"/${P}-static-libs.patch \
		"${FILESDIR}"/${P}-gles-wayland.patch
	AT_M4DIR="/usr/share/aclocal acinclude" eautoreconf
}

src_configure() {
	use custom-cflags || strip-flags

	# sorted by `./configure --help`
	econf \
		$(use_enable static-libs static) \
		$(use_enable sound audio) \
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
		$(use_enable sound diskaudio) \
		$(use_enable sound dummyaudio) \
		$(use_enable X video-x11) \
		--disable-x11-shared \
		$(use_enable wayland video-wayland) \
		--disable-wayland-shared \
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
	use static-libs || prune_libtool_files
	dodoc {BUGS,CREDITS,README,README-SDL,README-hg,TODO,WhatsNew}.txt
}
