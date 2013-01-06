# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/rezerwar/rezerwar-0.4.2.ebuild,v 1.2 2010/06/21 20:14:25 maekke Exp $

EAPI=2
inherit eutils games

DESCRIPTION="Puzzle game like the known tetromino and the average pipe games"
HOMEPAGE="http://tamentis.com/projects/rezerwar/"
SRC_URI="http://tamentis.com/projects/rezerwar/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="media-libs/libsdl[audio,joystick,video]
	media-libs/sdl-mixer[vorbis]"

src_prepare() {
	sed -i \
		-e '/check_sdl$/d' \
		-e 's/-O2 //' \
		configure \
		|| die 'sed failed'
	sed -i \
		-e '/CC.*OBJECTS/s:$(CC):$(CC) $(LDFLAGS):' \
		mkfiles/Makefile.src \
		|| die "sed failed"
}

src_configure() {
	SDLCONFIG=sdl-config \
	TARGET_BIN="${GAMES_BINDIR}" \
	TARGET_DOC=/usr/share/doc/${PF} \
	TARGET_DATA="${GAMES_DATADIR}/${PN}" \
	./configure \
	|| die "configure failed"
	sed -i \
		-e '/TARGET_DOC/d' \
		Makefile \
		|| die "sed failed"
}

src_install() {
	dodir "${GAMES_BINDIR}"
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc doc/{CHANGES,README,TODO}
	make_desktop_entry rezerwar Rezerwar
	prepgamesdirs
}
