# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/shootingstar/shootingstar-1.2.0.ebuild,v 1.7 2009/10/19 05:01:04 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="A topdown shooter"
HOMEPAGE="http://www.2ndpoint.fi/ss"
SRC_URI="http://www.2ndpoint.fi/ss/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/opengl
	virtual/glu
	media-libs/libsdl[video]
	media-libs/sdl-mixer
	media-libs/sdl-image"

PATCHES=(
	"${FILESDIR}"/${PV}-gcc34.patch
	"${FILESDIR}"/${P}-gcc44.patch
)

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	newicon data/textures/body1.png ${PN}.png
	make_desktop_entry ${PN} "Shooting Star"
	dodoc AUTHORS ChangeLog NEWS README TODO
	prepgamesdirs
}
