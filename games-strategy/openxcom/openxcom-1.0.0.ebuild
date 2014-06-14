# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/openxcom/openxcom-1.0.0.ebuild,v 1.1 2014/06/14 16:15:27 maksbotan Exp $

EAPI=5

inherit cmake-utils games

DESCRIPTION="An open-source reimplementation of the popular UFO: Enemy Unknown"
HOMEPAGE="http://openxcom.org/"
SRC_URI="http://openxcom.org/wp-content/uploads/downloads/2014/06/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc"

RDEPEND="app-arch/unzip
	>=dev-cpp/yaml-cpp-0.5.1
	media-libs/libsdl
	media-libs/sdl-gfx
	media-libs/sdl-image
	media-libs/sdl-mixer"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

DOCS=( README.txt )

src_configure() {
	mycmakeargs=(
		"-DCMAKE_INSTALL_PREFIX=${GAMES_PREFIX}"
		"-DDATADIR=${GAMES_DATADIR}/${PN}"
	)
	cmake-utils_src_configure
}

src_compile() {
	use doc && cmake-utils_src_compile doxygen
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
	use doc && dohtml -r "${CMAKE_BUILD_DIR}"/docs/html/*
	doicon res/linux/icons/openxcom.svg
	domenu res/linux/openxcom.desktop

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "In order to play you need to copy GEODATA, GEOGRAPH, MAPS, ROUTES, SOUND,"
	elog "TERRAIN, UFOGRAPH, UFOINTRO, UNITS folders from the original X-COM game to"
	elog "${GAMES_DATADIR}/${PN}/data"
}
