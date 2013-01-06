# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/xwelltris/xwelltris-1.0.1.ebuild,v 1.15 2008/03/15 04:34:31 mr_bones_ Exp $

inherit games

DESCRIPTION="2.5D tetris like game"
HOMEPAGE="http://xnc.jinr.ru/xwelltris/"
SRC_URI="http://xnc.jinr.ru/xwelltris/src/${P}.src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-image"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/INSTALL_PROGRAM/s/-s //' \
		src/Make.common.in \
		|| die "sed Make.common.in failed"
	sed -i \
		-e "/GLOBAL_SEARCH/s:\".*\":\"${GAMES_DATADIR}/${PN}\":" \
		src/include/globals.h.in \
		|| die "sed globals.h.in failed"
}

src_compile() {
	# configure/build process is pretty messed up
	egamesconf --with-sdl || die
	emake -C src || die "emake failed"
}

src_install() {
	dodir "${GAMES_BINDIR}" "${GAMES_DATADIR}/${PN}" /usr/share/man
	emake install \
		INSTDIR="${D}/${GAMES_BINDIR}" \
		INSTLIB="${D}/${GAMES_DATADIR}/${PN}" \
		INSTMAN=/usr/share/man \
		|| die "emake install failed"
	dodoc AUTHORS Changelog README*
	prepgamesdirs
}
