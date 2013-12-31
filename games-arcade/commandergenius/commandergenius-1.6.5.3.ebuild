# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/commandergenius/commandergenius-1.6.5.3.ebuild,v 1.1 2013/12/30 00:34:25 hasufell Exp $

EAPI=5

CMAKE_IN_SOURCE_BUILD=1
inherit cmake-utils eutils games

MY_P=CGenius-${PV}-Release-Source
DESCRIPTION="Open Source Commander Keen clone (needs original game files)"
HOMEPAGE="http://clonekeenplus.sourceforge.net"
SRC_URI="mirror://sourceforge/clonekeenplus/CGenius/V${PV:0:3}/${MY_P}.tar.gz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="opengl tremor"

RDEPEND="media-libs/libsdl[X,audio,opengl?,video]
	media-libs/sdl-image
	opengl? ( virtual/opengl )
	tremor? ( media-libs/tremor )
	!tremor? ( media-libs/libvorbis )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/${MY_P}

src_configure() {
	local mycmakeargs=(
		-DAPPDIR="${GAMES_BINDIR}"
		-DSHAREDIR="/usr/share"
		-DGAMES_SHAREDIR="${GAMES_DATADIR}"
		-DDOCDIR="/usr/share/doc/${PF}"
		-DBUILD_TARGET="LINUX"
		$(cmake-utils_use opengl OPENGL)
		$(cmake-utils_use tremor TREMOR)
		$(cmake-utils_use !tremor OGG)
		-DUSE_SDL2=0
	)

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
	newicon CGLogo.png ${PN}.png
	newgamesbin "${FILESDIR}"/commandergenius-wrapper commandergenius
	make_desktop_entry commandergenius
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "Check your settings in ~/.CommanderGenius/cgenius.cfg"
	elog "after you have started the game for the first time."
	use opengl && elog "You may also want to set \"OpenGL = true\""
	elog
	elog "Run the game via:"
	elog "    'commandergenius [path-to-keen-data]'"
	elog "or add your keen data dir to the search paths in cgenius.cfg"
}
