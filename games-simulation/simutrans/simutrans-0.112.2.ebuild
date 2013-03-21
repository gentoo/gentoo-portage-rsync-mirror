# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/simutrans/simutrans-0.112.2.ebuild,v 1.1 2013/03/21 01:44:13 mr_bones_ Exp $

EAPI=5
inherit flag-o-matic eutils games

MY_PV=${PV/0./}
MY_PV=${MY_PV//./-}
MY_FOOD_PV=${MY_PV/%-2/-1}
DESCRIPTION="A free Transport Tycoon clone"
HOMEPAGE="http://www.simutrans.com/"
SRC_URI="mirror://sourceforge/simutrans/simutrans-src-${MY_PV}.zip
	mirror://sourceforge/simutrans/simupak64-${MY_PV}.zip
	mirror://sourceforge/simutrans/simupak64-addon-food-${MY_FOOD_PV}.zip"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/libsdl[audio,video]
	sys-libs/zlib
	app-arch/bzip2
	media-libs/libpng:0
	media-libs/sdl-mixer"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}

src_prepare() {
	strip-flags # bug #293927
	echo "BACKEND=mixer_sdl
COLOUR_DEPTH=16
OSTYPE=linux
VERBOSE=1" > config.default || die

	if use !x86 ; then
		echo "FLAGS+= -DUSE_C" >> config.default || die
	fi
	# make it look in the install location for the data
	sed -i \
		-e "s:argv\[0\]:\"${GAMES_DATADIR}/${PN}/\":" \
		simmain.cc || die

	epatch \
		"${FILESDIR}"/${P}-Makefile.patch \
		"${FILESDIR}"/${P}-overflow.patch
}

src_install() {
	newgamesbin build/default/sim ${PN}
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r simutrans/*
	dodoc documentation/*
	doicon simutrans.ico
	make_desktop_entry simutrans Simutrans /usr/share/pixmaps/simutrans.ico
	prepgamesdirs
}
