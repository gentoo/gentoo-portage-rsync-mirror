# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/gemrb/gemrb-0.7.2.ebuild,v 1.2 2013/01/18 18:14:11 nimiux Exp $

EAPI=2
PYTHON_DEPEND="2"
WANT_CMAKE=always
inherit eutils python cmake-utils gnome2-utils games

DESCRIPTION="Reimplementation of the Infinity engine"
HOMEPAGE="http://gemrb.sourceforge.net/"
SRC_URI="mirror://sourceforge/gemrb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND="media-libs/freetype
	media-libs/libpng:0
	>=media-libs/libsdl-1.2[video]
	media-libs/libvorbis
	media-libs/openal
	media-libs/sdl-mixer
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
		-DSVG_DIR=/usr/share/icons/hicolor/scalable/apps
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

pkg_preinst() {
	games_pkg_preinst
	gnome2_icon_savelist
}

pkg_postinst() {
	games_pkg_postinst
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
