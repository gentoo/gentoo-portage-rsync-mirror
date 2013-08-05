# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/minetest_survival/minetest_survival-0.4.6.ebuild,v 1.1 2013/08/05 22:43:11 hasufell Exp $

EAPI=5
inherit vcs-snapshot games

DESCRIPTION="Survival game for the Minetest game engine"
HOMEPAGE="https://github.com/minetest/survival"
SRC_URI="https://github.com/minetest/survival/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2 CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=games-action/minetest-${PV}[-dedicated]"

src_unpack() {
	vcs-snapshot_src_unpack
}

src_install() {
	insinto "${GAMES_DATADIR}"/minetest/games/survival
	doins -r mods
	doins game.conf

	prepgamesdirs
}
