# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/hedgewars/hedgewars-0.9.18-r1.ebuild,v 1.4 2013/01/03 10:59:06 ago Exp $

EAPI=2
CMAKE_BUILD_TYPE=Release
inherit cmake-utils eutils games

MY_P=${PN}-src-${PV}-3
DESCRIPTION="Free Worms-like turn based strategy game"
HOMEPAGE="http://hedgewars.org/"
SRC_URI="http://download.gna.org/hedgewars/${MY_P}.tar.bz2"

LICENSE="GPL-2 Apache-2.0 FDL-1.3"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""
QA_FLAGS_IGNORED=${GAMES_BINDIR}/hwengine # pascal sucks
QA_PRESTRIPPED=${GAMES_BINDIR}/hwengine # pascal sucks

RDEPEND="x11-libs/qt-gui:4
	media-libs/freeglut
	virtual/ffmpeg
	media-libs/libsdl[audio,opengl,video]
	media-libs/sdl-ttf
	media-libs/sdl-mixer[vorbis]
	media-libs/sdl-image[png]
	media-libs/sdl-net
	dev-lang/lua"
DEPEND="${RDEPEND}
	>=dev-lang/fpc-2.4"
RDEPEND="${RDEPEND}
	>=media-fonts/dejavu-2.28"

S=${WORKDIR}/${PN}-src-${PV}

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-cflags.patch \
		"${FILESDIR}"/${P}-cmake.patch
}

src_configure() {
	mycmakeargs=(
		-DCMAKE_C_FLAGS_RELEASE='' \
		-DCMAKE_CXX_FLAGS_RELEASE='' \
		-DCMAKE_INSTALL_PREFIX="${GAMES_PREFIX}"
		-DDATA_INSTALL_DIR="${GAMES_DATADIR}"
		-DNOSERVER=TRUE
		-DCMAKE_VERBOSE_MAKEFILE=TRUE )
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	DOCS="ChangeLog.txt README" cmake-utils_src_install
	rm -f "${D}"/usr/share/games/hedgewars/Data/Fonts/DejaVuSans-Bold.ttf
	dosym /usr/share/fonts/dejavu/DejaVuSans-Bold.ttf \
		"${GAMES_DATADIR}"/hedgewars/Data/Fonts/DejaVuSans-Bold.ttf
	newicon QTfrontend/res/hh25x25.png ${PN}.png
	make_desktop_entry ${PN} Hedgewars
	doman man/${PN}.6
	prepgamesdirs
}
