# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/ri-li/ri-li-2.0.1.ebuild,v 1.7 2012/09/19 18:54:38 mr_bones_ Exp $

EAPI=2
inherit autotools eutils games

DESCRIPTION="Drive a toy wood engine and collect all the coaches"
HOMEPAGE="http://ri-li.sourceforge.net/"
SRC_URI="mirror://sourceforge/ri-li/Ri-li-${PV}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="media-libs/libsdl[audio,video]
	media-libs/sdl-mixer[mod]"

S=${WORKDIR}/Ri-li-${PV}

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc43.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	rm -f "${D}${GAMES_DATADIR}/Ri-li/"*ebuild
	newicon data/Ri-li-icon-48x48.png ${PN}.png
	make_desktop_entry Ri_li Ri-li
	dodoc AUTHORS NEWS README
	prepgamesdirs
}
