# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/yabause/yabause-0.9.12.ebuild,v 1.1 2013/02/18 00:36:27 hasufell Exp $

EAPI=5
inherit eutils cmake-utils games

DESCRIPTION="A Sega Saturn emulator"
HOMEPAGE="http://yabause.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="openal opengl qt4 sdl"

RDEPEND="
	openal? ( media-libs/openal )
	opengl? (
		media-libs/freeglut
		virtual/glu
		virtual/opengl
	)
	qt4? (
		x11-libs/qt-core:4
		x11-libs/qt-gui:4
		opengl? ( x11-libs/qt-opengl:4 )
	)
	!qt4? (
		dev-libs/glib:2
		x11-libs/gtk+:2
		x11-libs/gtkglext
	)
	sdl? ( media-libs/libsdl[opengl?,video] )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-RWX.patch \
		"${FILESDIR}"/${P}-cmake.patch
}

src_configure() {
	local mycmakeargs=(
		-DBINDIR="${GAMES_BINDIR}"
		-DTRANSDIR="${GAMES_DATADIR}"/${PN}/yts
		-DYAB_OPTIMIZATION=""
		$(cmake-utils_use sdl YAB_WANT_SDL)
		$(cmake-utils_use openal YAB_WANT_OPENAL)
		$(cmake-utils_use opengl YAB_WANT_OPENGL)
		-DYAB_PORTS=$(usex qt4 "qt" "gtk")
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
	dodoc AUTHORS ChangeLog GOALS README README.LIN
	prepgamesdirs
}
