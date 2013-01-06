# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/ensemblist/ensemblist-040126.ebuild,v 1.11 2012/11/18 05:57:10 ssuominen Exp $

EAPI=2
inherit eutils games

DESCRIPTION="Put together several primitives to build a given shape. (C.S.G. Game)"
HOMEPAGE="http://www.nongnu.org/ensemblist/index_en.html"
SRC_URI="http://savannah.nongnu.org/download/ensemblist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

DEPEND="media-libs/freeglut
	media-libs/libmikmod:0
	media-libs/libpng:0
	virtual/glu
	virtual/opengl
	x11-libs/libXmu"

PATCHES=( "${FILESDIR}"/${P}-build.patch )

src_compile() {
	emake DATADIR="\"${GAMES_DATADIR}\"/${PN}/datas" \
		CFLAGSLD="${LDFLAGS}" \
		|| die
}

src_install() {
	dogamesbin ensemblist || die
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r datas || die
	dodoc Changelog README
	make_desktop_entry ${PN} Ensemblist
	prepgamesdirs
}
