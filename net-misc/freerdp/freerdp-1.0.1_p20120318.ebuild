# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/freerdp/freerdp-1.0.1_p20120318.ebuild,v 1.4 2012/11/29 04:39:19 floppym Exp $

EAPI="4"

inherit cmake-utils

if [[ ${PV} != 9999* ]]; then
	SRC_URI="mirror://github/FreeRDP/FreeRDP/${P}.tar.gz
		mirror://gentoo/${P}.tar.gz
		http://dev.gentoo.org/~floppym/distfiles/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
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
IUSE="alsa cups directfb doc ffmpeg pulseaudio smartcard sse2 X xinerama xv"
RESTRICT="test"

RDEPEND="
	dev-libs/openssl
	sys-libs/zlib
	alsa? ( media-libs/alsa-lib )
	cups? ( net-print/cups )
	directfb? ( dev-libs/DirectFB )
	ffmpeg? ( virtual/ffmpeg )
	pulseaudio? ( media-sound/pulseaudio )
	smartcard? ( sys-apps/pcsc-lite )
	X? (
		x11-libs/libX11
		x11-libs/libXcursor
		x11-libs/libXext
		x11-libs/libxkbfile
		xinerama? ( x11-libs/libXinerama )
		xv? ( x11-libs/libXv )
	)
"
DEPEND="${RDEPEND}
	doc? (
		X? (
			app-text/docbook-xml-dtd:4.1.2
			app-text/xmlto
		)
	)
"

DOCS=( README )

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with alsa ALSA)
		$(cmake-utils_use_with cups CUPS)
		$(cmake-utils_use_with doc MANPAGES)
		$(cmake-utils_use_with directfb DIRECTFB)
		$(cmake-utils_use_with ffmpeg FFMPEG)
		$(cmake-utils_use_with pulseaudio PULSEAUDIO)
		$(cmake-utils_use_with smartcard PCSC)
		$(cmake-utils_use_with sse2 SSE2)
		$(cmake-utils_use_with X X11)
		$(cmake-utils_use_with X XCURSOR)
		$(cmake-utils_use_with X XEXT)
		$(cmake-utils_use_with X XKBFILE)
		$(cmake-utils_use_with xinerama XINERAMA)
		$(cmake-utils_use_with xv XV)
	)
	cmake-utils_src_configure
}
