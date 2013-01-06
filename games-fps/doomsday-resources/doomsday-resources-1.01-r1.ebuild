# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/doomsday-resources/doomsday-resources-1.01-r1.ebuild,v 1.3 2012/07/06 09:52:26 ago Exp $

inherit eutils games

DESCRIPTION="Improved models & textures for doomsday"
HOMEPAGE="http://www.doomsdayhq.com/"
SRC_URI="mirror://sourceforge/deng/jdoom-resource-pack-${PV}.zip
	mirror://sourceforge/deng/jdoom-details.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=games-fps/doomsday-1.9.8"
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
