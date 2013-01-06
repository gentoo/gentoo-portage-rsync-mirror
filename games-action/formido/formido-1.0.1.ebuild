# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/formido/formido-1.0.1.ebuild,v 1.2 2010/03/16 14:56:18 mr_bones_ Exp $

inherit eutils toolchain-funcs games

DESCRIPTION="A shooting game in the spirit of Phobia games"
HOMEPAGE="http://www.mhgames.org/oldies/formido/"
SRC_URI="http://noe.falzon.free.fr/prog/${P}.tar.gz
	http://koti.mbnet.fi/lsoft/formido/formido-music.tar.bz2"

LICENSE="GPL-2"
SLOT=0
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer"

src_unpack() {
	unpack ${P}.tar.gz
	cd "${S}"
	sed -i \
		-e "s:g++:$(tc-getCXX):" \
		-e "/^FLAGS=/s:$: ${CXXFLAGS}:" \
		-e "/^LINKFLAGS=/s:=.*:=${LDFLAGS}:" \
		-e "s:\${DATDIR}:${GAMES_DATADIR}/${PN}/data:" \
		-e "s:\${DEFCONFIGDIR}:${GAMES_DATADIR}/${PN}:" \
		Makefile \
		|| die "sed failed"
	cd data
	unpack ${PN}-music.tar.bz2
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r ${PN}.cfg data || die "doins failed"
	newicon data/icon.dat ${PN}.bmp
	make_desktop_entry ${PN} Formido /usr/share/pixmaps/${PN}.bmp
	dodoc README README-1.0.1
	prepgamesdirs
}
