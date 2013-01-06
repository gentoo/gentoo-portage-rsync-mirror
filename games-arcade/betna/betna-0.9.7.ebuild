# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/betna/betna-0.9.7.ebuild,v 1.10 2010/09/08 15:38:25 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="Defend your volcano from the attacking ants by firing rocks/bullets at them"
HOMEPAGE="http://koti.mbnet.fi/makegho/c/betna/"
SRC_URI="http://koti.mbnet.fi/makegho/c/betna/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="media-libs/libsdl[video]"

src_prepare() {
	sed -i \
		-e '/blobprintf.*char msg/s/char msg/const char msg/' \
		-e "s:images/:${GAMES_DATADIR}/${PN}/:" \
		src/main.cpp || die

	sed -i \
		-e '/^LDFLAGS/d' \
		-e '/--libs/s/-o/$(LDFLAGS) -o/' \
		-e 's:-O2:$(CXXFLAGS):g' \
		-e 's/g++/$(CXX)/' \
		Makefile || die
}

src_compile() {
	emake clean || die
	emake || die
}

src_install() {
	dogamesbin betna || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins images/* || die "doins failed"
	newicon images/target.bmp ${PN}.bmp
	make_desktop_entry ${PN} Betna /usr/share/pixmaps/${PN}.bmp
	dodoc README Q\&A
	prepgamesdirs
}
