# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/minetest_game/minetest_game-0.4.7.ebuild,v 1.5 2013/12/11 20:42:07 hasufell Exp $

EAPI=5
inherit vcs-snapshot games

DESCRIPTION="The main game for the Minetest game engine"
HOMEPAGE="http://github.com/minetest/minetest_game"
SRC_URI="http://github.com/minetest/minetest_game/tarball/${PV} -> ${P}.tar.gz"

LICENSE="GPL-2 CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="~games-action/minetest-${PV}[-dedicated]"

src_unpack() {
	vcs-snapshot_src_unpack
}

src_install() {
	insinto "${GAMES_DATADIR}"/minetest/games/${PN}
	doins -r mods menu
	doins game.conf

	dodoc README.txt

	prepgamesdirs
}
