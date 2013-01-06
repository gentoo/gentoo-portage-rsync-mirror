# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/galaxyhack/galaxyhack-1.74.ebuild,v 1.5 2012/11/04 18:30:21 tupone Exp $

EAPI=4
inherit eutils flag-o-matic games

DESCRIPTION="Multiplayer AI script based strategy game."
HOMEPAGE="http://galaxyhack.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2
	mirror://gentoo/${PN}.png"

LICENSE="GPL-2 galaxyhack"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer
	>=dev-libs/boost-1.34"

S=${WORKDIR}/${PN}/src

src_prepare() {
	edos2unix Makefile
	epatch \
		"${FILESDIR}"/${P}-destdirs.patch \
		"${FILESDIR}"/${P}-boost.patch \
		"${FILESDIR}"/${P}-gcc43.patch \
		"${FILESDIR}"/${P}-boost-1.50.patch \
		"${FILESDIR}"/${P}-gentoo.patch
	sed -i "s:@GAMES_DATADIR@:${GAMES_DATADIR}:" \
		Main.cpp \
		|| die "sed Main.cpp failed"
	sed -i "/Base data path/s:pwd:${GAMES_DATADIR}/${PN}:" \
		../settings.dat \
		|| die "sed settings.dat failed"
}

src_install() {
	dogamesbin "${PN}"
	cd ..
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r fleets gamedata graphics music standardpictures \
		settings.dat
	dodoc readme.txt
	doicon "${DISTDIR}"/${PN}.png
	make_desktop_entry ${PN} GalaxyHack
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "Settings will default to those found in"
	elog "${GAMES_DATADIR}/galaxyhack/settings.dat"
	elog "Per user settings can be specified by creating"
	elog "~/.galaxyhack/settings.dat"
	elog "Additional user submitted fleets can be downloaded from"
	elog "http://galaxyhack.sourceforge.net/viewfleets.php"
}
