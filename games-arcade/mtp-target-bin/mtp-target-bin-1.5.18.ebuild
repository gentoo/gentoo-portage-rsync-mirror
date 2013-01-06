# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/mtp-target-bin/mtp-target-bin-1.5.18.ebuild,v 1.3 2012/12/22 21:08:01 tupone Exp $

EAPI=5
inherit games

MY_PN=${PN/-bin}
MY_PV=${PV/1.5./}

DESCRIPTION="a Monkey Target clone (six mini-game from Super Monkey Ball)"
HOMEPAGE="http://www.mtp-target.org/"
SRC_URI="http://www.mtp-target.org/files/${MY_PN}-setup.${MY_PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="strip"

QA_PREBUILT="${GAMES_PREFIX_OPT:1}/${PN}/lib/libfmodex.so
	${GAMES_PREFIX_OPT:1}/${PN}/bin/client"

DEPEND=""
RDEPEND="dev-libs/STLport
	sys-libs/zlib
	dev-libs/libxml2
	x11-libs/libXmu
	virtual/opengl
	=media-libs/freetype-2*
	virtual/jpeg
	dev-lang/lua"

S=${WORKDIR}/${MY_PN}

src_install() {
	insinto "${GAMES_PREFIX_OPT}/${PN}/data"
	doins -r data/* client/mtp_target_default.cfg
	insinto "${GAMES_PREFIX_OPT}/${PN}/bin"
	exeinto "${GAMES_PREFIX_OPT}/${PN}/bin"
	doexe client/client
	doins client/mtp_target_default.cfg
	insinto "${GAMES_PREFIX_OPT}/${PN}/lib"
	doins client/libfmodex.so
	games_make_wrapper ${PN} ./client "${GAMES_PREFIX_OPT}/${PN}/bin" ../lib
	prepgamesdirs
	fperms 664 "${GAMES_PREFIX_OPT}/${PN}/bin/mtp_target_default.cfg"
}
