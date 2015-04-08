# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/solarus/solarus-1.1.1.ebuild,v 1.4 2015/02/01 13:46:04 ago Exp $

EAPI=5

inherit cmake-utils games

DESCRIPTION="An open-source Zelda-like 2D game engine"
HOMEPAGE="http://www.solarus-games.org/"
SRC_URI="http://www.zelda-solarus.com/downloads/${PN}/${P}-src.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="
	dev-games/physfs
	dev-lang/lua
	media-libs/libmodplug
	media-libs/libsdl[X,joystick,video]
	media-libs/libvorbis
	media-libs/openal
	media-libs/sdl-image[png]
	media-libs/sdl-ttf"
DEPEND="${RDEPEND}"

DOCS=( ChangeLog readme.txt )
PATCHES=( "${FILESDIR}"/${P}-paths.patch )

src_prepare() {
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DSOLARUS_INSTALL_DESTINATION="${GAMES_BINDIR}"
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
	prepgamesdirs
}
