# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/bumprace/bumprace-1.5.3.ebuild,v 1.5 2014/12/16 04:10:39 mr_bones_ Exp $

EAPI=5
inherit eutils games

DESCRIPTION="simple arcade racing game"
HOMEPAGE="http://www.linux-games.com/bumprace/"
SRC_URI="http://user.cs.tu-berlin.de/~karlb/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~sparc x86"
IUSE=""

DEPEND="media-libs/libsdl[sound,video]
	media-libs/sdl-mixer[mod]
	virtual/jpeg:0
	sys-libs/zlib
	media-libs/sdl-image[gif,jpeg,png]"
RDEPEND=${DEPEND}

src_install() {
	default
	make_desktop_entry bumprace BumpRace
	prepgamesdirs
}
