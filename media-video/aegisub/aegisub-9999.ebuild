# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/aegisub/aegisub-9999.ebuild,v 1.2 2013/10/13 16:41:10 tomwij Exp $

EAPI="5"

AUTOTOOLS_AUTORECONF="1"
AUTOTOOLS_IN_SOURCE_BUILD="1"
WX_GTK_VER="2.9"
inherit autotools-utils wxwidgets git-2

DESCRIPTION="Advanced SSA/ASS subtitle editor"
HOMEPAGE="http://www.aegisub.org/"
EGIT_REPO_URI="git://github.com/Aegisub/Aegisub.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="alsa debug +ffmpeg fftw lua openal oss portaudio pulseaudio spell"

REQUIRED_USE="
	|| ( alsa openal oss portaudio pulseaudio )
"

RDEPEND="
	>=x11-libs/wxGTK-2.9.3:${WX_GTK_VER}[X,opengl,debug?]
	virtual/opengl
	virtual/glu
	>=media-libs/libass-0.10.0[fontconfig]
	virtual/libiconv
	>=media-libs/fontconfig-2.4.2
	>=media-libs/freetype-2.3.5:2

	alsa? ( >=media-libs/alsa-lib-1.0.16 )
	portaudio? ( =media-libs/portaudio-19* )
	pulseaudio? ( >=media-sound/pulseaudio-0.9.5 )
	openal? ( media-libs/openal )

	lua? ( >=dev-lang/lua-5.1.1 )

	spell? ( >=app-text/hunspell-1.2.2 )
	ffmpeg? ( >=media-libs/ffmpegsource-2.17:= )
	fftw? ( >=sci-libs/fftw-3.3 )
"
DEPEND="${RDEPEND}
	oss? ( virtual/os-headers )
	>=sys-devel/gettext-0.18
	dev-util/intltool
	virtual/pkgconfig
"

EGIT_SOURCEDIR="${WORKDIR}/${P}"
S="${WORKDIR}/${P}/${PN}"

src_configure() {
	local myeconfargs=(
		$(use_with alsa)
		$(use_with oss)
		$(use_with portaudio)
		$(use_with pulseaudio libpulse)
		$(use_with openal)
		$(use_with lua)
		$(use_with ffmpeg ffms2)
		$(use_with fftw fftw3)
		$(use_with spell hunspell)
		$(use_enable debug)
	)
	autotools-utils_src_configure
}
