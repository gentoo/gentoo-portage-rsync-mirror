# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/doomsday-resources/doomsday-resources-1.01.ebuild,v 1.4 2010/07/18 09:45:56 fauli Exp $

inherit eutils games

DESCRIPTION="Improved models & textures for doomsday"
HOMEPAGE="http://www.doomsdayhq.com/"
SRC_URI="mirror://sourceforge/deng/jdoom-resource-pack-${PV}.zip
	mirror://sourceforge/deng/jdoom-details.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="games-fps/doomsday"
DEPEND="app-arch/unzip"

S=${WORKDIR}

src_install() {
	insinto "${GAMES_DATADIR}"/doomsday/data/jdoom/auto
	doins data/jDoom/* *.pk3 || die "doins failed"

	# The definitions file cannot be auto-loaded
	insinto "${GAMES_DATADIR}"/doomsday/defs/jdoom
	doins defs/jDoom/* || die "doins failed"

	dodoc *.txt docs/*
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "Add the following to the jdoom/doomsday command-line options:"
	elog "  -def ${GAMES_DATADIR}/doomsday/defs/jdoom/jDRP.ded"
}
