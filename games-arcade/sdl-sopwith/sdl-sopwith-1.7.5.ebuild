# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/sdl-sopwith/sdl-sopwith-1.7.5.ebuild,v 1.1 2013/01/21 05:09:59 mr_bones_ Exp $

EAPI=2
inherit eutils autotools games

MY_P=${P/sdl-/}
DESCRIPTION="Port of the classic Sopwith game using LibSDL"
HOMEPAGE="http://sdl-sopwith.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=">=media-libs/libsdl-1.1.3[video]"

S=${WORKDIR}/${MY_P}

src_prepare() {
	rm acconfig.h
	epatch "${FILESDIR}"/${P}-nogtk.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog FAQ NEWS README TODO doc/*txt
	rm -rf "${D}/usr/games/share/"
	prepgamesdirs
}
