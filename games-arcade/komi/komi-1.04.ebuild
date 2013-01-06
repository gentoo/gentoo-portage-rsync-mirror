# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/komi/komi-1.04.ebuild,v 1.6 2010/08/25 16:24:44 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="Komi the Space Frog - simple SDL game of collection"
HOMEPAGE="http://komi.sourceforge.net"
SRC_URI="mirror://sourceforge/komi/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND="media-libs/libsdl[video]
	media-libs/sdl-mixer"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-DESTDIR.patch
	sed -i \
		-e "/^BINPATH/s:=.*:=${GAMES_BINDIR}/:" \
		-e "/^DATAPATH/s:=.*:=${GAMES_DATADIR}/${PN}/:" \
		-e '/^SDL_LIB/s:$: $(LDFLAGS):' \
		-e '/^SDL_LIB/s:--static-:--:' \
		Makefile \
		|| die "sed failed"
}

src_compile() {
	emake ECFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	newicon komidata/sprites_komi.bmp ${PN}.bmp
	make_desktop_entry komi Komi /usr/share/pixmaps/${PN}.bmp
	doman komi.6
	dodoc CHANGELOG.txt README.txt TROUBLESHOOTING.txt
	prepgamesdirs
}
