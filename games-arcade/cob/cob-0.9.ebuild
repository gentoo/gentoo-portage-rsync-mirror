# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/cob/cob-0.9.ebuild,v 1.14 2015/01/03 19:31:13 tupone Exp $

EAPI=5
inherit eutils games

DESCRIPTION="Cruising on Broadway: a painting-type game"
HOMEPAGE="http://www.autismuk.freeserve.co.uk/"
SRC_URI="http://www.autismuk.freeserve.co.uk/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ppc ~sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="media-libs/libsdl"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}"/${P}-gcc43.patch
	"${FILESDIR}"/${P}-gcc44.patch
)

src_install() {
	default
	prepgamesdirs
}
