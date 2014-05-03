# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/digger/digger-20020314.ebuild,v 1.14 2014/05/03 18:44:09 ulm Exp $

EAPI=2
inherit eutils games

DESCRIPTION="Digger Remastered"
HOMEPAGE="http://www.digger.org/"
SRC_URI="http://www.digger.org/${P}.tar.gz"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""
RESTRICT="mirror bindist"

DEPEND="media-libs/libsdl[video]"

PATCHES=( "${FILESDIR}"/${P}-ldflags.patch )

src_compile() {
	emake -f Makefile.sdl || die
}

src_install() {
	dogamesbin digger || die "dogamesbin failed"
	dodoc digger.txt
	make_desktop_entry digger Digger
	prepgamesdirs
}
