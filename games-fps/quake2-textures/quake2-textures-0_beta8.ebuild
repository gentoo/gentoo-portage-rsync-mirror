# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake2-textures/quake2-textures-0_beta8.ebuild,v 1.4 2014/04/24 19:05:50 ulm Exp $

inherit eutils versionator games

MY_PV=$(get_version_component_range 2-2)
MY_PV=${MY_PV/beta/}

DESCRIPTION="High-resolution textures for Quake 2"
HOMEPAGE="http://jdolan.tastyspleen.net/"
SRC_URI="http://jdolan.tastyspleen.net/pak${MY_PV}.zip"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror bindist"

RDEPEND=""
DEPEND="app-arch/unzip"

S=${WORKDIR}
dir=${GAMES_DATADIR}/quake2

src_install() {
	insinto "${dir}"/baseq2
	doins *.pak || die "doins *.pak failed"

	dodoc README

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	elog "Use a recent Quake 2 client to take advantage of"
	elog "these textures, e.g. qudos or quake2-icculus."
	echo
}
