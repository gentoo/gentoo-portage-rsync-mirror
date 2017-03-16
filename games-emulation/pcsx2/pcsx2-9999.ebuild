# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PLOCALES="ar_SA ca_ES cs_CZ de_DE es_ES fi_FI fr_FR hr_HR hu_HU id_ID it_IT ja_JP ko_KR ms_MY nb_NO pl_PL pt_BR ru_RU sv_SE th_TH tr_TR zh_CN zh_TW"

inherit cmake-utils git-r3 l10n multilib wxwidgets

DESCRIPTION="A PlayStation 2 emulator"
HOMEPAGE="http://www.pcsx2.net"
EGIT_REPO_URI="git://github.com/PCSX2/pcsx2.git"

LICENSE="GPL-3"
SLOT="0"

IUSE="png +wxwidgets3"

RDEPEND="
	app-arch/bzip2[abi_x86_32]
	app-arch/xz-utils[abi_x86_32]
	dev-libs/libaio[abi_x86_32]
	media-libs/alsa-lib[abi_x86_32]
	media-libs/libpng:=[abi_x86_32]
	media-libs/libsdl[abi_x86_32,joystick,sound]
	media-libs/libsoundtouch[abi_x86_32]
	media-libs/portaudio[abi_x86_32]
	>=sys-libs/zlib-1.2.4[abi_x86_32]
	virtual/jpeg:62[abi_x86_32]
	virtual/opengl[abi_x86_32]
	x11-libs/gtk+:2[abi_x86_32]
	x11-libs/libICE[abi_x86_32]
	x11-libs/libX11[abi_x86_32]
	x11-libs/libXext[abi_x86_32]

	!wxwidgets3? ( x11-libs/wxGTK:2.8[abi_x86_32,X] )
	wxwidgets3? ( x11-libs/wxGTK:3.0[abi_x86_32,X] )
"
DEPEND="${RDEPEND}
	!<app-eselect/eselect-opengl-1.3.1
	png? ( dev-cpp/pngpp )
	>=dev-cpp/sparsehash-1.5
	!<sys-devel/gcc-4.8
"

# Upstream issue: https://github.com/PCSX2/pcsx2/issues/417
QA_TEXTRELS="usr/lib32/pcsx2/*"

clean_locale() {
	rm -Rf "${S}"/locales/"${1}" || die
}

src_prepare() {
	cmake-utils_src_prepare

	ebegin "Cleaning up locales..."
	l10n_for_each_disabled_locale_do clean_locale
	eend $?

	epatch_user
}

src_configure() {
	multilib_toolchain_setup x86

	# pcsx2 build scripts will force CMAKE_BUILD_TYPE=Devel
	# if it something other than "Devel|Debug|Release"
	local CMAKE_BUILD_TYPE="Release"

	if use amd64; then
		# Passing correct CMAKE_TOOLCHAIN_FILE for amd64
		# https://github.com/PCSX2/pcsx2/pull/422
		local MYCMAKEARGS=(-DCMAKE_TOOLCHAIN_FILE=cmake/linux-compiler-i386-multilib.cmake)
	fi

	local mycmakeargs=(
		-DARCH_FLAG=
		-DDISABLE_BUILD_DATE=TRUE
		-DDISABLE_PCSX2_WRAPPER=TRUE
		-DEXTRA_PLUGINS=FALSE
		-DOPTIMIZATION_FLAG=
		-DPACKAGE_MODE=TRUE
		-DXDG_STD=TRUE

		-DCMAKE_INSTALL_PREFIX=/usr
		-DCMAKE_LIBRARY_PATH=/usr/$(get_libdir)/"${PN}"
		-DDOC_DIR=/usr/share/doc/"${PF}"
		-DEGL_API=FALSE
		-DGTK3_API=FALSE
		-DPLUGIN_DIR=/usr/$(get_libdir)/"${PN}"
		# wxGTK must be built against same sdl version
		-DSDL2_API=FALSE

		$(cmake-utils_useno wxwidgets3 DWX28_API)
	)

	local WX_GTK_VER="3.0"
	if ! use wxwidgets3; then
		WX_GTK_VER="2.8"
	fi

	need-wxwidgets unicode
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
}
