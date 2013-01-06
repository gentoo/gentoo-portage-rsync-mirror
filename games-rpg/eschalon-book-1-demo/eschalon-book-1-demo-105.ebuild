# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/eschalon-book-1-demo/eschalon-book-1-demo-105.ebuild,v 1.2 2010/02/08 14:54:42 fauli Exp $

EAPI=2
inherit eutils games

DESCRIPTION="A classic role-playing game"
HOMEPAGE="http://basiliskgames.com/eschalon-book-i"
SRC_URI="${P//-/_}.tar.gz"

LICENSE="eschalon-book-1-demo"
SLOT="0"
KEYWORDS="x86"
IUSE=""
RESTRICT="fetch strip"
QA_EXECSTACK="${GAMES_PREFIX_OPT:1}/${PN}/Eschalon Book I Demo"

RDEPEND="virtual/opengl
	virtual/glu
	x11-libs/libX11
	x11-libs/libXxf86vm
	sys-devel/gcc"

S=${WORKDIR}/eschalon_book_1_demo

pkg_nofetch() {
	einfo "Please download ${SRC_URI} from:"
	einfo "  ${HOMEPAGE}"
	einfo "and move it to ${DISTDIR}"
	echo
}

src_install () {
	insinto "${GAMES_PREFIX_OPT}/${PN}"
	doins -r data music sound *pdf *pak *html *txt \
		|| die "doins failed"

	exeinto "${GAMES_PREFIX_OPT}/${PN}"
	doexe "Eschalon Book I Demo" || die "doexe failed"

	make_desktop_entry ${PN} "Eschalon: Book I (Demo)"
	games_make_wrapper ${PN} "\"./Eschalon Book I Demo\"" "${GAMES_PREFIX_OPT}/${PN}"
	prepgamesdirs
}
