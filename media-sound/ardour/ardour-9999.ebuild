# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ardour/ardour-9999.ebuild,v 1.1 2013/09/10 20:14:00 nativemad Exp $

EAPI=4
inherit eutils git-2 toolchain-funcs flag-o-matic waf-utils

DESCRIPTION="Digital Audio Workstation"
HOMEPAGE="http://ardour.org/"
EGIT_REPO_URI="git://git.ardour.org/ardour/ardour.git"

if [ ${PV} = 9999 ]; then
	KEYWORDS=""
else
	EGIT_COMMIT="${PV}"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="3"
IUSE="altivec debug doc nls lv2 sse"

RDEPEND="media-libs/aubio
	media-libs/liblo
	sci-libs/fftw:3.0
	media-libs/freetype:2
	>=dev-libs/glib-2.10.1:2
	dev-cpp/glibmm:2
	>=x11-libs/gtk+-2.8.1:2
	>=dev-libs/libxml2-2.6:2
	>=media-libs/libsndfile-1.0.18
	>=media-libs/libsamplerate-0.1
	>=media-libs/rubberband-1.6.0
	>=media-libs/libsoundtouch-1.6.0
	media-libs/flac
	media-libs/raptor:2
	>=media-libs/liblrdf-0.4.0-r20
	>=media-sound/jack-audio-connection-kit-0.120
	>=gnome-base/libgnomecanvas-2
	media-libs/vamp-plugin-sdk
	dev-libs/libxslt
	dev-libs/libsigc++:2
	>=dev-cpp/gtkmm-2.16:2.4
	>=dev-cpp/libgnomecanvasmm-2.26:2.6
	media-libs/alsa-lib
	x11-libs/pango
	x11-libs/cairo
	media-libs/libart_lgpl
	virtual/libusb:0
	dev-libs/boost
	>=media-libs/taglib-1.7
	net-misc/curl
	lv2? (
		>=media-libs/slv2-0.6.1
		media-libs/lilv
		media-libs/sratom
		dev-libs/sord
		>=media-libs/suil-0.6.10

	)"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )
	doc? ( app-doc/doxygen[dot] )"

src_unpack() {
	git-2_src_unpack
}

src_prepare(){
	epatch "${FILESDIR}"/${PN}-3.2-syslibs.patch
	sed 's/python/python2/' -i waf
}

src_configure() {
	tc-export CC CXX
	mkdir -p "${D}"
	waf-utils_src_configure \
		--destdir="${D}" \
		--prefix=/usr \
		--configdir=/etc \
		$(use lv2 && echo "--lv2" || echo "--no-lv2") \
		$(use nls && echo "--nls" || echo "--no-nls") \
		$(use debug && echo "--stl-debug") \
		$((use altivec || use sse) && echo "--fpu-optimization" || echo "--no-fpu-optimization") \
		$(use doc && echo "--docs")
}

src_install() {
	waf-utils_src_install
	mv ${PN}.1 ${PN}${SLOT}.1
	doman ${PN}${SLOT}.1
	newicon icons/icon/ardour_icon_mac.png ${PN}${SLOT}.png
	make_desktop_entry ardour3 ardour3 ardour3 AudioVideo
}
