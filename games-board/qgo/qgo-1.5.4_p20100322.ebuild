# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/qgo/qgo-1.5.4_p20100322.ebuild,v 1.8 2010/11/08 16:29:48 mr_bones_ Exp $

EAPI=2
inherit eutils qt4-r2 games

DESCRIPTION="An ancient boardgame, very common in Japan, China and Korea"
HOMEPAGE="http://qgo.sourceforge.net/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="media-libs/alsa-lib
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-test:4"

src_prepare() {
	sed -i \
		-e "/QGO_INSTALL_PATH/s:/usr/share:${GAMES_DATADIR}:" \
		-e "/QGO_INSTALL_BIN_PATH/s:/usr/bin:${GAMES_BINDIR}:" \
		-e 's:$(QTDIR)/bin/lrelease:lrelease:' \
		src/src.pro || die

	sed -i \
		-e "/TRANSLATIONS_PATH_PREFIX/s:/usr/share:${GAMES_DATADIR}:" \
		src/defines.h || die

	epatch \
		"${FILESDIR}"/${P}-gcc45.patch \
		"${FILESDIR}"/${P}-qt47.patch
}

src_configure() {
	eqmake4 qgo2.pro
}

src_install() {
	qt4-r2_src_install

	dodoc AUTHORS

	insinto "${GAMES_DATADIR}"/qgo/languages
	doins src/translations/*.qm || die

	prepgamesdirs
}
