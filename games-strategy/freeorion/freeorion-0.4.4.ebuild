# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/freeorion/freeorion-0.4.4.ebuild,v 1.2 2015/01/20 08:27:24 tomka Exp $

EAPI=5

PYTHON_COMPAT=( python2_6 python2_7 )
inherit cmake-utils python-any-r1 games

DESCRIPTION="A free turn-based space empire and galactic conquest game"
HOMEPAGE="http://www.freeorion.org"
SRC_URI="http://dev.gentoo.org/~tomka/files/${P}.tar.bz2
		 http://dev.gentoo.org/~tomka/files/${P}-ogre-1.9-compat.patch.bz2"

LICENSE="GPL-2 LGPL-2.1 CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="cg"

# Needs it's own version of GG(dev-games/gigi) which it ships.
# The split version dev-games/gigi is not used anymore as of 0.4.3
RDEPEND="
	!dev-games/gigi
	dev-games/ogre[cg?,ois,opengl]
	dev-games/ois
	>=dev-libs/boost-1.47[python]
	media-libs/freealut
	media-libs/libogg
	media-libs/libsdl[X,opengl,video]
	media-libs/libvorbis
	media-libs/openal
	sci-physics/bullet
	sys-libs/zlib
	virtual/opengl"
DEPEND="${RDEPEND}
	${PYTHON_DEPS}
	virtual/pkgconfig"

CMAKE_USE_DIR="${S}"
CMAKE_VERBOSE="1"

pkg_setup() {
	# build system is using FindPythonLibs.cmake which needs python:2
	python-any-r1_pkg_setup
	games_pkg_setup
}

src_prepare() {
	# set OGRE plugin-dir
	sed \
		-e "s:PluginFolder=.*$:PluginFolder=$(pkg-config --variable=plugindir OGRE):" \
		-i "${CMAKE_USE_DIR}"/ogre_plugins.cfg.in || die

	if use cg ; then
		# add cg ogre plugin to config
		echo "Plugin=Plugin_CgProgramManager" \
			>> "${CMAKE_USE_DIR}"/ogre_plugins.cfg || die
	fi

	epatch "${WORKDIR}/${P}-ogre-1.9-compat.patch"

	# parse subdir sets -O3
	sed -e "s:-O3::" -i parse/CMakeLists.txt

	# set revision for display in game -- update on bump!
	sed -i -e 's/???/7708/' CMakeLists.txt
}

src_configure() {
	local mycmakeargs=(
		-DRELEASE_COMPILE_FLAGS=""
		-DCMAKE_SKIP_RPATH=ON
		)

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	# data files
	rm "${CMAKE_USE_DIR}"/default/COPYING || die
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r "${CMAKE_USE_DIR}"/default || die

	# bin
	dogamesbin "${CMAKE_BUILD_DIR}"/${PN}{ca,d} || die
	newgamesbin "${CMAKE_BUILD_DIR}"/${PN} ${PN}.bin || die
	games_make_wrapper ${PN} \
		"${GAMES_BINDIR}/${PN}.bin --resource-dir ${GAMES_DATADIR}/${PN}/default" \
		"${GAMES_DATADIR}/${PN}"

	# lib
	dogameslib "${CMAKE_BUILD_DIR}"/libfreeorion{common,parse}.so || die
	dogameslib "${CMAKE_BUILD_DIR}"/libGiGi*.so || die

	# config
	insinto "${GAMES_SYSCONFDIR}"/${PN}
	doins "${CMAKE_BUILD_DIR}"/ogre_plugins.cfg || die
	doins "${CMAKE_USE_DIR}"/OISInput.cfg || die
	# game uses relative paths
	dosym "${GAMES_SYSCONFDIR}"/${PN}/ogre_plugins.cfg \
		"${GAMES_DATADIR}"/${PN}/ogre_plugins.cfg || die
	dosym "${GAMES_SYSCONFDIR}"/${PN}/OISInput.cfg \
		"${GAMES_DATADIR}"/${PN}/OISInput.cfg || die

	# other
	dodoc "${CMAKE_USE_DIR}"/changelog.txt || die
	newicon "${CMAKE_USE_DIR}"/default/data/art/icons/FO_Icon_32x32.png \
		${PN}.png || die
	make_desktop_entry ${PN} ${PN} ${PN}

	# permissions
	prepgamesdirs
}
