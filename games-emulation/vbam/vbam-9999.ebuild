# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/vbam/vbam-9999.ebuild,v 1.5 2013/06/15 09:26:01 radhermit Exp $

EAPI=4
WX_GTK_VER="2.8"

inherit cmake-utils wxwidgets subversion gnome2-utils fdo-mime games

ESVN_REPO_URI="https://vbam.svn.sourceforge.net/svnroot/vbam/trunk"

DESCRIPTION="Game Boy, GBC, and GBA emulator forked from VisualBoyAdvance"
HOMEPAGE="http://vba-m.ngemu.com"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="cairo ffmpeg gtk link lirc nls openal +sdl wxwidgets"
REQUIRED_USE="|| ( sdl gtk wxwidgets )"

RDEPEND=">=media-libs/libpng-1.4
	media-libs/libsdl[joystick]
	link? ( media-libs/libsfml )
	sys-libs/zlib
	virtual/glu
	virtual/opengl
	ffmpeg? ( virtual/ffmpeg )
	gtk? ( >=dev-cpp/glibmm-2.4.0:2
		>=dev-cpp/gtkmm-2.4.0:2.4
		>=dev-cpp/gtkglextmm-1.2.0 )
	lirc? ( app-misc/lirc )
	nls? ( virtual/libintl )
	wxwidgets? (
		cairo? ( x11-libs/cairo )
		openal? ( media-libs/openal )
		x11-libs/wxGTK:2.8[X,opengl]
	)"
DEPEND="${RDEPEND}
	wxwidgets? ( || ( media-gfx/imagemagick media-gfx/graphicsmagick[imagemagick] ) )
	x86? ( || ( dev-lang/nasm dev-lang/yasm ) )
	nls? ( sys-devel/gettext )
	virtual/pkgconfig"

src_prepare() {
	# Fix issue with zlib-1.2.5.1 macros (bug #383179)
	sed -i '1i#define OF(x) x' src/common/memgzio.c || die

	sed -i "s:\(DESTINATION\) bin:\1 ${GAMES_BINDIR}:" \
		CMakeLists.txt src/wx/CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_enable cairo CAIRO)
		$(cmake-utils_use_enable ffmpeg FFMPEG)
		$(cmake-utils_use_enable gtk GTK)
		$(cmake-utils_use_enable link LINK)
		$(cmake-utils_use_enable lirc LIRC)
		$(cmake-utils_use_enable nls NLS)
		$(cmake-utils_use_enable openal OPENAL)
		$(cmake-utils_use_enable sdl SDL)
		$(cmake-utils_use_enable wxwidgets WX)
		$(cmake-utils_use_enable x86 ASM_CORE)
		$(cmake-utils_use_enable x86 ASM_SCALERS)
		-DCMAKE_SKIP_RPATH=ON
		-DDATA_INSTALL_DIR=share/games/${PN}
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install

	if use sdl ; then
		dodoc doc/ReadMe.SDL.txt || die
		doman debian/vbam.1 || die
	fi

	prepgamesdirs
}

pkg_preinst() {
	games_pkg_preinst
	if use gtk || use wxwidgets ; then
		gnome2_icon_savelist
	fi
}

pkg_postinst() {
	games_pkg_postinst
	if use gtk || use wxwidgets ; then
		gnome2_icon_cache_update
	fi
	use gtk && fdo-mime_desktop_database_update
}

pkg_postrm() {
	if use gtk || use wxwidgets ; then
		gnome2_icon_cache_update
	fi
	use gtk && fdo-mime_desktop_database_update
}
