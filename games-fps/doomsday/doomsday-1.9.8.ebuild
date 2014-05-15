# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/doomsday/doomsday-1.9.8.ebuild,v 1.9 2014/05/15 16:44:21 ulm Exp $

EAPI=4

PYTHON_DEPEND="snowberry? 2"

inherit python confutils eutils qt4-r2 games

DESCRIPTION="A modern gaming engine for Doom, Heretic, and Hexen"
HOMEPAGE="http://www.dengine.net/"
SRC_URI="mirror://sourceforge/deng/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="openal snowberry +doom demo freedoom heretic hexen resources"

DEPEND="
	virtual/opengl
	virtual/glu
	media-libs/libsdl[joystick,sound]
	media-libs/sdl-mixer
	media-libs/libpng
	dev-qt/qtopengl:4
	dev-qt/qtgui:4
	net-misc/curl
	openal? ( media-libs/openal )"
RDEPEND="${DEPEND}
	snowberry? ( dev-python/wxpython )"
PDEPEND="
	demo? ( games-fps/doom-data )
	freedoom? ( games-fps/freedoom )
	resources? ( games-fps/doomsday-resources )"

S=${S}/${PN}

REQUIRED_USE="demo? ( doom ) freedoom? ( doom ) resources? ( doom )"
PATCHES=(
	"${FILESDIR}"/${P}-2to3.patch
	"${FILESDIR}"/${P}-openal-64bit-fix.patch
)

pkg_setup(){
	python_pkg_setup
	games_pkg_setup
}

src_prepare() {
	sed -i -e "/^DENG_BASE_DIR =/s:\$\$PREFIX/share:${GAMES_DATADIR}:" config_unix.pri
	echo "CONFIG += nostrip" > config_user.pri
	echo "PREFIX=/usr/games" >> config_user.pri
	use snowberry && \
		echo "CONFIG += deng_snowberry" >> config_user.pri || \
		echo "CONFIG += deng_nosnowberry" >> config_user.pri

	if use openal; then
		echo "CONFIG += deng_openal" >> config_user.pri
		sed -i 's:\# Generic Unix.:LIBS += -lopenal:' dep_openal.pri || die
		epatch "${FILESDIR}"/${P}-openal-link.patch
	fi

	qt4-r2_src_prepare
}

#Usage: doom_make_wrapper <name> <game> <icon> <desktop entry title> [args]
doom_make_wrapper() {
	local name=$1 game=$2 icon=$3 de_title=$4
	shift 4
	games_make_wrapper $name \
		"doomsday -game ${game} $@"
	make_desktop_entry $name "${de_title}" ${icon}
}

src_configure() {
	qt4-r2_src_configure
}

src_install() {
	qt4-r2_src_install

	mv "${D}/${GAMES_DATADIR}"/{${PN}/data/jdoom,doom-data} || die
	dosym "${GAMES_DATADIR}"/doom-data "${GAMES_DATADIR}"/${PN}/data/jdoom || die

	if use snowberry; then
		doicon ../snowberry/graphics/snowberry.png
		python_convert_shebangs 2 "${D}"/"${GAMES_BINDIR}"/launch-doomsday
		make_desktop_entry launch-doomsday "Snowberry DoomsDay" snowberry
	fi

	if use doom; then
		local res_arg
		if use resources; then
			res_arg="-def \"${GAMES_DATADIR}\"/${PN}/defs/jdoom/jDRP.ded"
		fi

		doicon ../snowberry/graphics/orb-doom.png
		doom_make_wrapper jdoom doom1 orb-doom "DoomsDay Engine: Doom 1" "${res_arg}"
		elog "Created jdoom launcher. To play Doom place your doom.wad to"
		elog "\"${GAMES_DATADIR}\"/doom-data"
		elog

		if use demo; then
			doom_make_wrapper jdoom-demo doom1-share orb-doom "DoomsDay Engine: Doom 1 Demo" \
				"-iwad \"${GAMES_DATADIR}\"/doom-data/doom1.wad ${res_arg}"
		fi
		if use freedoom; then
			doom_make_wrapper jdoom-freedoom doom1-share orb-doom "DoomsDay Engine: FreeDoom" \
				"-iwad \"${GAMES_DATADIR}\"/doom-data/freedoom/doom1.wad"
		fi
	fi
	if use hexen; then
		doicon ../snowberry/graphics/orb-hexen.png
		doom_make_wrapper jhexen hexen orb-hexen "DoomsDay Engine: Hexen"

		elog "Created jhexen launcher. To play Hexen place your hexen.wad to"
		elog "\"${GAMES_DATADIR}\"/${PN}/data/jhexen"
		elog
	fi
	if use heretic; then
		doicon ../snowberry/graphics/orb-heretic.png
		doom_make_wrapper jheretic heretic orb-heretic "DoomsDay Engine: Heretic"

		elog "Created jheretic launcher. To play Heretic place your heretic.wad to"
		elog "\"${GAMES_DATADIR}\"/${PN}/data/jheretic"
		elog
	fi

	prepgamesdirs
}
