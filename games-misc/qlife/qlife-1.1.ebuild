# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/qlife/qlife-1.1.ebuild,v 1.5 2013/03/02 21:17:46 hwoarang Exp $

EAPI=2
inherit eutils qt4-r2 games

MY_PN=${PN/ql/QL}

DESCRIPTION="Simulates the classical Game of Life invented by John Conway"
HOMEPAGE="http://open-maker.tuxfamily.org/blog/index.php?post/2009/03/28/QLife"
SRC_URI="http://open-maker.tuxfamily.org/blog/public/${PN}_linux.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="dev-qt/qtgui:4"

S=${WORKDIR}/${MY_PN}/sources

src_configure() {
	eqmake4 ${MY_PN}.pro
}

src_install() {
	dogamesbin ${MY_PN} || die
	newicon data/egg.png ${PN}.png
	make_desktop_entry ${MY_PN} ${MY_PN}
	prepgamesdirs
}
