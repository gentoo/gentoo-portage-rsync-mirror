# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/violetland/violetland-0.4.2.ebuild,v 1.3 2011/08/21 03:29:30 phajdan.jr Exp $

EAPI=2
inherit eutils cmake-utils games

DESCRIPTION="Help a girl by name of Violet to struggle with hordes of monsters."
HOMEPAGE="http://code.google.com/p/violetland/"
SRC_URI="http://violetland.googlecode.com/files/${PN}-v${PV}-src.zip"

LICENSE="GPL-3 CCPL-Attribution-ShareAlike-3.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="media-libs/libsdl[audio,video]
	media-libs/sdl-image[png]
	media-libs/sdl-mixer[vorbis]
	media-libs/sdl-ttf
	dev-libs/boost
	virtual/opengl
	virtual/glu"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/${PN}-v${PV}

src_prepare() {
	sed -i \
		-e "/README_EN.TXT/d" \
		-e "/README_RU.TXT/d" \
		CMakeLists.txt || die "sed failed"
}

src_configure() {
	mycmakeargs=(
		"-DCMAKE_INSTALL_PREFIX=${GAMES_PREFIX}"
		"-DDATA_INSTALL_DIR=${GAMES_DATADIR}"
		)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	DOCS="README_EN.TXT CHANGELOG" cmake-utils_src_install
	newicon icon-light.png ${PN}.png
	make_desktop_entry ${PN} VioletLand
	prepgamesdirs
}
