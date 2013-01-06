# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/OilWar/OilWar-1.2.1-r1.ebuild,v 1.3 2008/10/07 17:21:27 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="Evil army is attacking your country and tries to steal your oil"
HOMEPAGE="http://www.2ndpoint.fi/projektit/oilwar.html"
SRC_URI="http://www.2ndpoint.fi/projektit/filut/${P}.tar.gz
	mirror://gentoo/${PN}.png"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer"

src_unpack() {
	unpack ${P}.tar.gz
	cd "${S}"
	sed -i \
		-e '/^CXXCOMPILE/s:$(CPPFLAGS):$(SDL_CFLAGS):' \
		-e '/^datafiledir/s:/games/:/:' \
		-e '/install-data-am:/s:\\::' \
		-e '/install-data-local$/d' \
		Makefile.in \
		|| die "sed failed"
}

src_compile() {
	egamesconf --enable-sound || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
	doicon "${DISTDIR}"/${PN}.png
	make_desktop_entry oilwar ${PN}
	fperms 664 "${GAMES_STATEDIR}/oilwar.scores"
	prepgamesdirs
}
