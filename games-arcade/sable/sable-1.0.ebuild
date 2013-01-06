# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/sable/sable-1.0.ebuild,v 1.7 2009/11/21 19:22:55 maekke Exp $

EAPI=2
inherit eutils games

DESCRIPTION="A frantic 3D space shooter"
HOMEPAGE="http://www.stanford.edu/~mcmartin/sable/"
SRC_URI="http://www.stanford.edu/~mcmartin/${PN}/${P}-src.tgz
	mirror://gentoo/${PN}.png"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="virtual/opengl
	media-libs/libsdl
	media-libs/sdl-image[png]
	media-libs/sdl-mixer"

S=${WORKDIR}/${PN}

PATCHES=( "${FILESDIR}"/${P}-gentoo.patch )

src_compile() {
	emake INSTALL_RESDIR="${GAMES_DATADIR}" || die "emake failed"
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r models sfx textures || die "doins failed"
	dodoc ChangeLog README

	doicon "${DISTDIR}"/${PN}.png
	make_desktop_entry ${PN} Sable

	prepgamesdirs
}
