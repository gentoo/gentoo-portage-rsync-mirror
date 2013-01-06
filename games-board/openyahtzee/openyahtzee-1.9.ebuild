# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/openyahtzee/openyahtzee-1.9.ebuild,v 1.7 2011/06/20 11:48:11 tupone Exp $

EAPI=2
WX_GTK_VER="2.8"
inherit eutils autotools wxwidgets games

DESCRIPTION="A full-featured wxWidgets version of the classic dice game Yahtzee"
HOMEPAGE="http://openyahtzee.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND="x11-libs/wxGTK:2.8[X]"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc45.patch \
		"${FILESDIR}"/${P}-underlink.patch
	eautoreconf
}

src_configure() {
	egamesconf --datadir=/usr/share || die
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog TODO
	prepgamesdirs
}
