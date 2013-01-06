# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/scramble/scramble-0.9.5.ebuild,v 1.2 2007/04/26 07:20:11 mr_bones_ Exp $

inherit games

DESCRIPTION="Create as many words as you can before the time runs out"
HOMEPAGE="http://www.shiftygames.com/scramble/scramble.html"
SRC_URI="http://www.shiftygames.com/scramble/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND=">=media-libs/libsdl-1.2
	>=media-libs/sdl-mixer-1.2
	>=media-libs/sdl-image-1.2
	media-libs/sdl-ttf"
RDEPEND="${DEPEND}
	sys-apps/miscfiles"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	prepgamesdirs
}
