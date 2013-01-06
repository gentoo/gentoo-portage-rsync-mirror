# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/seven-kingdoms-data/seven-kingdoms-data-2.13.ebuild,v 1.1 2012/11/19 14:39:43 pinkbyte Exp $

EAPI=4

inherit games

MY_PN="7kaa"

DESCRIPTION="Seven Kingdoms: Ancient Adversaries game data files"
HOMEPAGE="http://7kfans.com/"
SRC_URI="mirror://sourceforge/skfans/${MY_PN}-data-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}"

src_install() {
	# Install readme and remove unneeded files
	newdoc README-GameData README
	rm README-GameData COPYING || die 'rm failed'

	# Install game data
	insinto "${GAMES_DATADIR}/${MY_PN}"
	doins -r *

	prepgamesdirs
}

pkg_postinst() {
	elog
	elog 'This tarball does not contain music files for Seven Kingodoms, as said on 7kfans.com:'
	elog '"The music is the work of Bjorn Lynne Copyright (c) 1997, and is not provided under the GPL.'
	elog 'It may be freely downloaded and used with Seven Kingdoms, but not modified or repurposed into derivative works."'
	elog
	games_pkg_postinst
}
