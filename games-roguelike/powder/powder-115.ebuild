# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/powder/powder-115.ebuild,v 1.3 2011/05/23 12:04:25 tomka Exp $

EAPI=2
inherit flag-o-matic games

MY_P=${P/-/}_src

DESCRIPTION="A game in the genre of Rogue, Nethack, and Diablo. Emphasis is on tactical play."
HOMEPAGE="http://www.zincland.com/powder/"
SRC_URI="http://www.zincland.com/powder/release/${MY_P}.tar.gz"

LICENSE="CCPL-Sampling-Plus-1.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="media-libs/libsdl[video]"

S=${WORKDIR}/${MY_P}

src_compile() {
	append-cxxflags -DCHANGE_WORK_DIRECTORY
	emake -j1 -C port/linux || die
}

src_install() {
	dogamesbin port/linux/${PN} || die
	dodoc README.TXT CREDITS.TXT
	prepgamesdirs
}

pkg_postinst() {
	elog "While the highscore is kept, save games are never preserved between"
	elog "versions. Please wait until your current character dies before upgrading."
	games_pkg_postinst
}
