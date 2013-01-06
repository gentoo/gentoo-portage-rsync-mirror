# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/aegisub/aegisub-2.1.9999.ebuild,v 1.3 2012/09/24 13:51:49 pinkbyte Exp $

EAPI="4"

WX_GTK_VER="2.8"
inherit autotools wxwidgets subversion

DESCRIPTION="Advanced SSA/ASS subtitle editor"
HOMEPAGE="http://www.aegisub.org/"
ESVN_REPO_URI="http://svn.aegisub.org/branches/aegisub_2.1.9/aegisub/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="alsa debug +ffmpeg lua nls openal oss portaudio pulseaudio spell"

RDEPEND="
	x11-libs/wxGTK:${WX_GTK_VER}[X,opengl,debug?]
	virtual/opengl
	virtual/glu
	>=media-libs/libass-0.9.11[fontconfig]
	virtual/libiconv
	>=media-libs/fontconfig-2.4.2
	media-libs/freetype:2

	alsa? ( media-libs/alsa-lib )
	portaudio? ( =media-libs/portaudio-19* )
	pulseaudio? ( media-sound/pulseaudio )
	openal? ( media-libs/openal )

	lua? ( >=dev-lang/lua-5.1.1 )

	spell? ( >=app-text/hunspell-1.2 )
	ffmpeg? ( >=media-libs/ffmpegsource-2.17 )
"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig
	media-gfx/imagemagick
"

src_prepare() {
	subversion_wc_info
	echo "${ESVN_WC_REVISION}" > svn_revision

	sh autogen.sh --skip-configure
	eautoreconf
}

src_configure() {
	econf \
		$(use_with alsa) \
		$(use_with oss) \
		$(use_with portaudio) \
		$(use_with pulseaudio) \
		$(use_with openal) \
		$(use_with lua) \
		$(use_with ffmpeg ffms) \
		$(use_with spell hunspell) \
		$(use_enable debug) \
		$(use_enable nls)
}
