# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/dolphin/dolphin-9999.ebuild,v 1.23 2015/03/09 21:07:44 twitch153 Exp $

EAPI=5

WX_GTK_VER="3.0"

inherit cmake-utils eutils pax-utils toolchain-funcs versionator wxwidgets games

if [[ ${PV} == 9999* ]]
then
	EGIT_REPO_URI="https://github.com/dolphin-emu/dolphin"
	inherit git-2
	KEYWORDS=""
else
	SRC_URI="http://${PN}-emu.googlecode.com/files/${P}-src.zip"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Gamecube and Wii game emulator"
HOMEPAGE="https://www.dolphin-emu.org/"

LICENSE="GPL-2"
SLOT="0"
IUSE="alsa ao bluetooth doc ffmpeg +lzo openal opengl openmp portaudio pulseaudio"

RDEPEND=">=media-libs/glew-1.10
	>=media-libs/libsfml-2.1
	>=net-libs/miniupnpc-1.8
	sys-libs/readline:=
	x11-libs/libXext
	x11-libs/libXrandr
	media-libs/libsdl2[haptic,joystick]
	net-libs/polarssl[havege]
	alsa? ( media-libs/alsa-lib )
	ao? ( media-libs/libao )
	bluetooth? ( net-wireless/bluez )
	ffmpeg? ( virtual/ffmpeg )
	lzo? ( dev-libs/lzo )
	openal? ( media-libs/openal )
	opengl? ( virtual/opengl )
	portaudio? ( media-libs/portaudio )
	pulseaudio? ( media-sound/pulseaudio )
	"
DEPEND="${RDEPEND}
	app-arch/zip
	media-gfx/nvidia-cg-toolkit
	media-libs/freetype
	media-libs/libsoundtouch
	>=sys-devel/gcc-4.6.0
	x11-libs/wxGTK:${WX_GTK_VER}
	"

pkg_pretend() {

	local ver=4.6.0
	local msg="${PN} needs at least GCC ${ver} set to compile."

	if [[ ${MERGE_TYPE} != binary ]]; then
		if ! version_is_at_least ${ver} $(gcc-fullversion); then
			eerror ${msg}
			die ${msg}
		fi
	fi

}

src_prepare() {

	# Remove automatic dependencies to prevent building without flags enabled.
	if use !alsa; then
		sed -i -e '/include(FindALSA/d' CMakeLists.txt || die
	fi
	if use !ao; then
		sed -i -e '/check_lib(AO/d' CMakeLists.txt || die
	fi
	if use !bluetooth; then
		sed -i -e '/check_lib(BLUEZ/d' CMakeLists.txt || die
	fi
	if use !openal; then
		sed -i -e '/include(FindOpenAL/d' CMakeLists.txt || die
	fi
	if use !portaudio; then
		sed -i -e '/CMAKE_REQUIRED_LIBRARIES portaudio/d' CMakeLists.txt || die
	fi
	if use !pulseaudio; then
		sed -i -e '/check_lib(PULSEAUDIO/d' CMakeLists.txt || die
	fi

	# Remove ALL the bundled libraries, aside from:
	# - SOIL: The sources are not public.
	# - Bochs-disasm: Don't know what it is.
	# - GL: A custom gl.h file is used.
	# - enet: Not fully supported yet.
	# - gtest: Their build set up solely relies on the build in gtest.
	# - xxhash: Not on the tree.
	mv Externals/SOIL . || die
	mv Externals/Bochs_disasm . || die
	mv Externals/GL . || die
	mv Externals/enet . || die
	mv Externals/gtest . || die
	mv Externals/xxhash . || die
	rm -r Externals/* || die "Failed to delete Externals dir."
	mv Bochs_disasm Externals || die
	mv SOIL Externals || die
	mv GL Externals || die
	mv enet Externals || die
	mv gtest Externals || die
	mv xxhash Externals || die
}

src_configure() {

	local mycmakeargs=(
		"-DDOLPHIN_WC_REVISION=${PV}"
		"-DCMAKE_INSTALL_PREFIX=${GAMES_PREFIX}"
		"-Dprefix=${GAMES_PREFIX}"
		"-Ddatadir=${GAMES_DATADIR}/${PN}"
		"-Dplugindir=$(games_get_libdir)/${PN}"
		$( cmake-utils_use ffmpeg ENCODE_FRAMEDUMPS )
		$( cmake-utils_use openmp OPENMP )
	)

	cmake-utils_src_configure
}

src_compile() {

	cmake-utils_src_compile
}
src_install() {

	cmake-utils_src_install

	dodoc Readme.md
	if use doc; then
		dodoc -r docs/ActionReplay docs/DSP docs/WiiMote
	fi

	doicon Installer/dolphin-emu.xpm
	make_desktop_entry "dolphin-emu" "Dolphin Emulator" "dolphin-emu" "Game;Emulator;"

	prepgamesdirs
}

pkg_postinst() {
	# Add pax markings for hardened systems
	pax-mark -m "${EPREFIX}"/usr/games/bin/"${PN}"-emu

	if ! use portaudio; then
		ewarn "If you want microphone capabilities in dolphin-emu, rebuild with"
		ewarn "USE=\"portaudio\""
	fi
}
