# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/bf1942-lnxded/bf1942-lnxded-1.61.ebuild,v 1.9 2014/04/30 19:25:04 ulm Exp $

inherit eutils unpacker games

DESCRIPTION="dedicated server for Battlefield 1942"
HOMEPAGE="http://www.eagames.com/official/battlefield/1942/us/editorial/serveradminfaq.jsp"
SRC_URI="http://bf1942.lightcubed.com/dist/${PN/-/_}-1.6-rc2.run
	ftp://largedownloads.ea.com/pub/misc/bf1942-update-${PV}.tar.gz"

LICENSE="bf1942-lnxded"
SLOT="0"
KEYWORDS="x86"
IUSE=""
RESTRICT="mirror bindist strip"

S=${WORKDIR}

dir=${GAMES_PREFIX_OPT}/bf1942
Ddir=${D}/${dir}

src_unpack() {
	mkdir bf1942 && cd bf1942
	unpack_makeself ${PN/-/_}-1.6-rc2.run
	cd ..
	unpack bf1942-update-${PV}.tar.gz
}

src_install() {
	dodir "${dir}"
	mv -f "${S}"/bf1942/* "${S}" || die "Copying patch files"
	rm -rf "${S}"/bf1942 || die "removing extra directory"

	mv "${S}"/* "${Ddir}" || die "Copying game data"
	dosym bf1942_lnxded.dynamic "${dir}"/bf1942_lnxded
	games_make_wrapper ${PN} ./bf1942_lnxded "${dir}"

	prepgamesdirs
}
