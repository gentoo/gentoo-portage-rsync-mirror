# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/freeorion/freeorion-0.4.2_pre20120910-r1.ebuild,v 1.2 2013/02/07 22:17:01 ulm Exp $

EAPI=4

PYTHON_DEPEND="2"

inherit cmake-utils python games

DESCRIPTION="A free turn-based space empire and galactic conquest game"
HOMEPAGE="http://www.freeorion.org"
SRC_URI="http://dev.gentoo.org/~tomka/files/FreeOrion-${PV}.tar.bz2"

LICENSE="GPL-2 CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="cg"

# Needs a dev-games/gigi from the freeorion source directory.
# It's safest to use the same version.
RDEPEND="
	dev-games/gigi[ogre,ois]
	dev-games/ogre[cg?,opengl]
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
	virtual/pkgconfig"

S="${WORKDIR}/FreeOrion-${PV}/"
CMAKE_USE_DIR="${S}"
CMAKE_VERBOSE="1"

pkg_setup() {
	# build system is using FindPythonLibs.cmake which needs python:2
	python_set_active_version 2
	python_pkg_setup
	games_pkg_setup
}

src_prepare() {
	# set OGRE plugin-dir
	sed \
		-e "s:PluginFolder=.:PluginFolder=$(pkg-config --variable=plugindir OGRE):" \
		-i "${CMAKE_USE_DIR}"/ogre_plugins.cfg || die

	if use cg ; then
		# add cg ogre plugin to config
		echo "Plugin=Plugin_CgProgramManager" \
			>> "${CMAKE_USE_DIR}"/ogre_plugins.cfg || die
	fi
}

src_configure() {
	local mycmakeargs=(
		-DRELEASE_COMPILE_FLAGS=""
		)

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	# data files
	rm "${CMAKE_USE_DIR}"/default/COPYING || die
	# get rid of .svn (remove from next snapshot!)
	find "${CMAKE_USE_DIR}"default/ -depth -type d -name .svn \
		-exec rm -rf '{}' \; || die
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r "${CMAKE_USE_DIR}"/default || die

	# bin
	dogamesbin "${CMAKE_BUILD_DIR}"/${PN}{ca,d} || die
	newgamesbin "${CMAKE_BUILD_DIR}"/${PN} ${PN}.bin || die
	games_make_wrapper ${PN} \
		"${GAMES_BINDIR}/${PN}.bin --resource-dir ./default" \
		"${GAMES_DATADIR}/${PN}"

	# config
	insinto "${GAMES_SYSCONFDIR}"/${PN}
	doins "${CMAKE_USE_DIR}"/{OISInput,ogre_plugins}.cfg || die
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
