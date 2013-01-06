# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/pengupop/pengupop-2.2.5.ebuild,v 1.5 2011/06/14 19:59:39 tupone Exp $

EAPI=2
inherit eutils autotools games

DESCRIPTION="Networked multiplayer-only Puzzle Bubble clone"
HOMEPAGE="http://freshmeat.net/projects/pengupop"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND="media-libs/libsdl[audio,video]
	sys-libs/zlib"

src_prepare() {
	epatch "${FILESDIR}"/${P}-underlink.patch

	sed -i \
		-e 's/-g -Wall -O2/-Wall/' \
		Makefile.am \
		|| die "sed failed"

	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README
	domenu pengupop.desktop
	doicon pengupop.png
	prepgamesdirs
}
