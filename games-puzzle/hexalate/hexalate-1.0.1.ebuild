# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/hexalate/hexalate-1.0.1.ebuild,v 1.3 2012/03/28 17:17:27 mr_bones_ Exp $

EAPI=2
inherit eutils qt4-r2 games

DESCRIPTION="A color matching game"
HOMEPAGE="http://gottcode.org/hexalate/"
SRC_URI="http://gottcode.org/${PN}/${P}-src.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="x11-libs/qt-core:4
	x11-libs/qt-gui:4"

src_configure() {
	qt4-r2_src_configure
}

src_install() {
	dogamesbin ${PN} || die
	doicon icons/${PN}.png
	domenu icons/${PN}.desktop
	dodoc README
	prepgamesdirs
}
