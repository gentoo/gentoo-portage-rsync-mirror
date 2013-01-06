# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/deathchase3d/deathchase3d-0.9.ebuild,v 1.5 2011/06/13 07:27:17 tupone Exp $
EAPI=2

inherit games

DESCRIPTION="A remake of the Sinclair Spectrum game of the same name"
HOMEPAGE="http://www.autismuk.freeserve.co.uk/"
SRC_URI="http://www.autismuk.freeserve.co.uk/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND="media-libs/libsdl"

PATCHES=( "${FILESDIR}"/${P}-underlink.patch )

src_install() {
	dogamesbin "${PN}/${PN}" || die "dogamesbin failed"
	dodoc README
	dohtml "${PN}/docs/en/index.html"
	prepgamesdirs
}
