# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/wizznic/wizznic-0.9.ebuild,v 1.4 2010/10/31 18:09:01 hwoarang Exp $

EAPI=2
inherit eutils games

EXTRA_PV="_feedback_version-src"
DESCRIPTION="Block-clearing puzzle game"
HOMEPAGE="http://wizznic.sourceforge.net/"
SRC_URI="mirror://sourceforge/wizznic/${P}${EXTRA_PV}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="media-libs/libsdl[audio,joystick,video]
	media-libs/sdl-image[png]
	media-libs/sdl-mixer[vorbis]"

S=${WORKDIR}/${P}${EXTRA_PV}

src_prepare() {
	sed \
		-e '/^\(CC\|LD\|STRIP\)/d' \
		-e 's/(LD)/(CC)/g' \
		Makefile.linux > Makefile \
		|| die
}

src_compile() {
	emake \
		DATADIR="${GAMES_DATADIR}/${PN}/" \
		BINDIR="${GAMES_BINDIR}" \
		STRIP=true \
		|| die
}

src_install() {
	emake \
		DESTDIR="${D}" \
		DATADIR="${GAMES_DATADIR}/${PN}/" \
		BINDIR="${GAMES_BINDIR}" \
		install || die
	dodoc doc/{changelog.txt,credits.txt,media-licenses.txt,ports.txt,readme.txt}
	newicon data/wmicon.png ${PN}.png
	make_desktop_entry wizznic "Wizznic!"
	prepgamesdirs
}
