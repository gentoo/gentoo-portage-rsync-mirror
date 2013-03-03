# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/ggencoder/ggencoder-0.91a.ebuild,v 1.4 2013/03/02 21:17:27 hwoarang Exp $

EAPI=4
inherit eutils qt4-r2

DESCRIPTION="Utility to encode and decode Game Genie (tm) codes."
HOMEPAGE="http://games.technoplaza.net/ggencoder/qt/"
SRC_URI="http://games.technoplaza.net/ggencoder/qt/history/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc"

DEPEND="dev-qt/qtcore:4
	dev-qt/qtgui:4"

S=${WORKDIR}/${P}/source

src_install() {
	dobin ${PN}
	dodoc ../docs/ggencoder.txt
	if use doc ; then
		dohtml -r ../apidocs/html/*
	fi
}
