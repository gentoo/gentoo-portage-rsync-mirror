# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gmchess/gmchess-0.29.6-r1.ebuild,v 1.4 2013/12/24 12:53:48 ago Exp $

EAPI=5
inherit autotools libtool gnome2-utils games

DESCRIPTION="Chinese chess with gtkmm and c++"
HOMEPAGE="http://code.google.com/p/gmchess/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.bz2"
RESTRICT="test"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-cpp/gtkmm:2.4"
RDEPEND=${DEPEND}

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.patch
	sed -i \
		-e "s:GAMES_LIBDIR:$(games_get_libdir):" \
		-e "s:GAMES_DATADIR:${GAMES_DATADIR}:" \
		src/engine/eleeye.cpp || die
	eautoreconf
}

src_configure() {
	egamesconf \
		--disable-static \
		--localedir='/usr/share/locale'
}

src_install() {
	emake DESTDIR="${D}" \
		itlocaledir='/usr/share/locale' \
		pixmapsdir='/usr/share/pixmaps' \
		desktopdir='/usr/share/applications' \
		install
	dodoc AUTHORS NEWS README
	prune_libtool_files
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
