# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/sdlroids/sdlroids-1.3.4-r3.ebuild,v 1.12 2008/02/29 18:52:45 carlo Exp $

inherit eutils games

DESCRIPTION="Asteroids Clone for X using SDL"
HOMEPAGE="http://david.hedbor.org/projects/sdlroids/"
SRC_URI="mirror://sourceforge/sdlroids/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc x86 ~x86-fbsd"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-mixer"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e 's/$(SOUNDSDIR)/$(DESTDIR)$(SOUNDSDIR)/' \
		-e 's/$(GFXDIR)/$(DESTDIR)$(GFXDIR)/' Makefile.in \
		|| die "sed failed"
	epatch "${FILESDIR}"/${PV}-sound.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	newicon icons/sdlroids-48x48.xpm ${PN}.xpm
	make_desktop_entry ${PN} SDLRoids ${PN}
	dodoc ChangeLog README.* TODO
	prepgamesdirs
}
