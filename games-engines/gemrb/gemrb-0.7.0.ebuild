# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/gemrb/gemrb-0.7.0.ebuild,v 1.7 2012/05/04 18:51:08 mr_bones_ Exp $

EAPI=2
PYTHON_DEPEND="2"
WANT_CMAKE=always
inherit eutils python cmake-utils games

DESCRIPTION="Reimplementation of the Infinity engine"
HOMEPAGE="http://gemrb.sourceforge.net/"
SRC_URI="mirror://sourceforge/gemrb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="media-libs/freetype
	media-libs/libpng
	>=media-libs/libsdl-1.2[video]
	media-libs/libvorbis
	media-libs/openal
	media-libs/sdl-mixer
	media-libs/sdl-ttf
	sys-libs/zlib"

pkg_setup() {
	python_set_active_version 2
	games_pkg_setup
}

src_prepare() {
	sed -i \
		-e '/COPYING/d' \
		CMakeLists.txt \
		|| die
}

src_configure() {
	mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="${GAMES_PREFIX}"
		-DBIN_DIR="${GAMES_BINDIR}"
		-DDATA_DIR="${GAMES_DATADIR}/gemrb"
		-DSYSCONF_DIR="${GAMES_SYSCONFDIR}/gemrb"
		-DLIB_DIR="$(games_get_libdir)"
		-DMAN_DIR=/usr/share/man/man6
		-DICON_DIR=/usr/share/pixmaps
		-DMENU_DIR=/usr/share/applications
		-DDOC_DIR="/usr/share/doc/${PF}"
		)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
	dodoc README NEWS AUTHORS
	prepgamesdirs
	prepalldocs
}
