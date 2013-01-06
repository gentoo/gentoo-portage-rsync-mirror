# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/fbg/fbg-0.9-r1.ebuild,v 1.11 2008/02/29 19:28:25 carlo Exp $

inherit eutils games

DESCRIPTION="A Tetris clone written in OpenGL"
HOMEPAGE="http://fbg.sourceforge.net/"
SRC_URI="mirror://sourceforge/fbg/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="virtual/opengl
	virtual/glu
	dev-games/physfs
	media-libs/libsdl
	media-libs/libmikmod
	x11-libs/libXt"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "/FBGDATADIR=/s:\".*\":\"${GAMES_DATADIR}/${PN}\":" \
		-e '/^datadir=/d' \
		configure \
		|| die "sed failed"
}

src_compile() {
	egamesconf --disable-fbglaunch || die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	newicon startfbg/icon.xpm ${PN}.xpm
	make_desktop_entry ${PN} "Falling Block Game" ${PN}
	dodoc AUTHORS ChangeLog README TODO
	rm -rf "${D}/${GAMES_PREFIX}"/doc
	prepgamesdirs
}
