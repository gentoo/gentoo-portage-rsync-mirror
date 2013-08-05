# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/minetest_common/minetest_common-0.4.6.ebuild,v 1.1 2013/08/05 22:37:45 hasufell Exp $

EAPI=5
inherit vcs-snapshot games

DESCRIPTION="Common game content mods, for use in various Minetest games"
HOMEPAGE="https://github.com/minetest/common"
SRC_URI="https://github.com/minetest/common/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2 CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=games-action/minetest-${PV}[-dedicated]"

src_unpack() {
	vcs-snapshot_src_unpack
}

src_install() {
	insinto "${GAMES_DATADIR}"/minetest/games/common
	doins -r mods

	prepgamesdirs
}
