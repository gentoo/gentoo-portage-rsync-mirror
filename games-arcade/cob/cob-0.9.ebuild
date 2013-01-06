# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/cob/cob-0.9.ebuild,v 1.13 2009/06/18 01:31:16 nyhm Exp $

EAPI=2
inherit eutils games

DESCRIPTION="Cruising on Broadway: a painting-type game"
HOMEPAGE="http://www.autismuk.freeserve.co.uk/"
SRC_URI="http://www.autismuk.freeserve.co.uk/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ppc ~sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="media-libs/libsdl"

PATCHES=(
	"${FILESDIR}"/${P}-gcc43.patch
	"${FILESDIR}"/${P}-gcc44.patch
)

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS README
	prepgamesdirs
}
