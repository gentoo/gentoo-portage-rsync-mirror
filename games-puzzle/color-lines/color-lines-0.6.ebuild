# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/color-lines/color-lines-0.6.ebuild,v 1.3 2014/05/15 16:49:40 ulm Exp $

EAPI=5

inherit eutils games

DESCRIPTION="Color lines game written with SDL with bonus features"
HOMEPAGE="http://color-lines.googlecode.com/"
SRC_URI="http://color-lines.googlecode.com/files/lines_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux"

RDEPEND="media-libs/libsdl[X,sound,video]
	media-libs/sdl-image[png]
	media-libs/sdl-mixer[wav,mod]"
DEPEND="${RDEPEND}"

S="${WORKDIR}/lines-${PV}"

src_prepare() {
	epatch "${FILESDIR}/${P}-Makefile.patch"

	sed -i \
		-e '/^Encoding/d' \
		-e '/^Version/d' \
		-e '/^Icon/s/.png//' \
		color-lines.desktop.in || die 'sed on color-lines.desktop.in failed'

	epatch_user
}

src_compile() {
	emake BINDIR="${EPREFIX}${GAMES_BINDIR}/" GAMEDATADIR="${EPREFIX}${GAMES_DATADIR}/${PN}/"
}

src_install() {
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r gfx sounds

	domenu ${PN}.desktop
	doicon icon/${PN}.png
	dodoc ChangeLog
	dogamesbin ${PN}

	prepgamesdirs
}
