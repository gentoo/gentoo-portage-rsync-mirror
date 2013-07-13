# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/freerdp/freerdp-1.1.0_beta1.ebuild,v 1.3 2013/07/13 21:25:48 ago Exp $

EAPI="5"

inherit cmake-utils

if [[ ${PV} != 9999* ]]; then
	MY_PV=${PV/_/-}
	MY_P=FreeRDP-${MY_PV}
	S=${WORKDIR}/${MY_P}
	SRC_URI="https://github.com/FreeRDP/FreeRDP/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="amd64 x86"
else
	inherit git-2
	SRC_URI=""
	EGIT_REPO_URI="git://github.com/FreeRDP/FreeRDP.git
		https://github.com/FreeRDP/FreeRDP.git"
	KEYWORDS=""
fi

DESCRIPTION="Free implementation of the Remote Desktop Protocol"
HOMEPAGE="http://www.freerdp.com/"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="alsa +channels +client cups debug directfb doc ffmpeg gstreamer jpeg
	pulseaudio smartcard sse2 test X xinerama xv"

RDEPEND="
	dev-libs/openssl
	sys-libs/zlib
	alsa? ( media-libs/alsa-lib )
	cups? ( net-print/cups )
	client? (
		directfb? ( dev-libs/DirectFB )
		X? (
			x11-libs/libXcursor
			x11-libs/libXext
			xinerama? ( x11-libs/libXinerama )
			xv? ( x11-libs/libXv )
		)
	)
	ffmpeg? ( virtual/ffmpeg )
	gstreamer? (
		media-libs/gstreamer:0.10
		media-libs/gst-plugins-base:0.10
		x11-libs/libXrandr
	)
	jpeg? ( virtual/jpeg )
	pulseaudio? ( media-sound/pulseaudio )
	smartcard? ( sys-apps/pcsc-lite )
	X? (
		x11-libs/libX11
		x11-libs/libxkbfile
	)
"
DEPEND="${RDEPEND}
	client? ( X? ( doc? (
		app-text/docbook-xml-dtd:4.1.2
		app-text/xmlto
	) ) )
"

DOCS=( README )

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with alsa ALSA)
		$(cmake-utils_use_with channels CHANNELS)
		$(cmake-utils_use_with client CLIENT)
		$(cmake-utils_use_with cups CUPS)
		$(cmake-utils_use_with debug DEBUG_ALL)
		$(cmake-utils_use_with doc MANPAGES)
		$(cmake-utils_use_with directfb DIRECTFB)
		$(cmake-utils_use_with ffmpeg FFMPEG)
		$(cmake-utils_use_with gstreamer GSTREAMER)
		$(cmake-utils_use_with jpeg JPEG)
		$(cmake-utils_use_with pulseaudio PULSEAUDIO)
		$(cmake-utils_use_with smartcard PCSC)
		$(cmake-utils_use_with sse2 SSE2)
		$(cmake-utils_use_with X X11)
		$(cmake-utils_use_with X XCURSOR)
		$(cmake-utils_use_with X XEXT)
		$(cmake-utils_use_with X XKBFILE)
		$(cmake-utils_use_with xinerama XINERAMA)
		$(cmake-utils_use_with xv XV)
		$(cmake-utils_use_build test TESTING)
	)
	cmake-utils_src_configure
}
