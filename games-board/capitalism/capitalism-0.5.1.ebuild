# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/capitalism/capitalism-0.5.1.ebuild,v 1.3 2011/01/15 14:36:44 maekke Exp $

EAPI=2
inherit eutils gnome2-utils qt4-r2 games

MY_PN=${PN/c/C}
MY_P=${MY_PN}_${PV}

DESCRIPTION="A monopd compatible boardgame to play Monopoly-like games"
HOMEPAGE="http://www.linux-ecke.de/Capitalism/"
SRC_URI="mirror://sourceforge/project/${PN}/${MY_PN}/0.5/${PN}_${PV}.tbz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="x11-libs/qt-gui:4"

S=${WORKDIR}/${MY_P}

PATCHES=( "${FILESDIR}"/${P}-qt47.patch )

src_configure() {
	qt4-r2_src_configure
}

src_install() {
	dogamesbin ${MY_PN} || die
	dodoc changelog readme.txt

	local res
	for res in 16 22 24 32 48 64; do
		insinto /usr/share/icons/hicolor/${res}x${res}/apps
		newins icons/${res}x${res}.png ${PN}.png
	done

	make_desktop_entry ${MY_PN} ${MY_PN}
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
