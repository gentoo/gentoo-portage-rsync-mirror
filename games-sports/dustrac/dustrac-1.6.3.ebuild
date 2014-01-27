# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/dustrac/dustrac-1.6.3.ebuild,v 1.1 2014/01/26 23:15:10 hasufell Exp $

EAPI=5

inherit eutils gnome2-utils cmake-utils games

DESCRIPTION="Tile-based, cross-platform 2D racing game"
HOMEPAGE="http://dustrac.sourceforge.net/"
SRC_URI="mirror://sourceforge/dustrac/${P}.tar.gz"

LICENSE="GPL-3 CC-BY-NC-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	dev-qt/qtopengl:4
	media-libs/libvorbis
	media-libs/openal
	media-libs/mesa[gles2]"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-cmake.patch \
		"${FILESDIR}"/${P}-desktopfile.patch
}

src_configure() {
	# build failure without gles 2.0
	local mycmakeargs=(
		-DGLES=ON
		-DGL30=ON
		-DReleaseBuild=ON
		-DDATA_PATH="${GAMES_DATADIR}/${PN}"
		-DBIN_PATH="${GAMES_BINDIR}"
		-DDOC_PATH=/usr/share/doc/${PF}
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
