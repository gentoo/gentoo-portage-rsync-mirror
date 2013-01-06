# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/barbarian-bin/barbarian-bin-1.01.ebuild,v 1.7 2007/01/17 21:27:48 nyhm Exp $

inherit eutils games

MY_PN=${PN/-bin/}
DESCRIPTION="Save Princess Mariana through one-on-one battles with demonic barbarians."
HOMEPAGE="http://www.tdbsoft.com/"
SRC_URI="http://www.pcpages.com/tomberrr/downloads/${MY_PN}${PV/./}_linux.zip"

LICENSE="CCPL-Attribution-NonCommercial-NoDerivs-2.0"
SLOT="0"
KEYWORDS="-* amd64 x86"
RESTRICT="strip"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND="x86? ( media-libs/libsdl )
	amd64? ( app-emulation/emul-linux-x86-sdl )"

S=${WORKDIR}

src_install() {
	local game_dest="${GAMES_PREFIX_OPT}/${MY_PN}"

	dodir "${game_dest}"
	cp -r gfx sounds "${D}${game_dest}/" || die "cp gfx sounds failed"

	exeinto "${game_dest}"
	doexe Barbarian || die "doexe failed"

	dohtml Barbarian.html || die "dohtml failed"

	games_make_wrapper barbarian ./Barbarian "${game_dest}"

	# High-score file
	dodir "${GAMES_STATEDIR}"
	touch "${D}${GAMES_STATEDIR}/heroes.hoh"
	fperms 660 "${GAMES_STATEDIR}/heroes.hoh"
	dosym "${GAMES_STATEDIR}/heroes.hoh" "${game_dest}/heroes.hoh"
	newicon gfx/sprites/player_attack_2_1.bmp barbarian.bmp
	make_desktop_entry barbarian "Barbarian" /usr/share/pixmaps/barbarian.bmp
	prepgamesdirs
}
