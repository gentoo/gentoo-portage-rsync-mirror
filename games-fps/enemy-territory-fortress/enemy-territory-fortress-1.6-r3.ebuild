# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/enemy-territory-fortress/enemy-territory-fortress-1.6-r3.ebuild,v 1.3 2012/02/05 06:02:27 vapier Exp $

EAPI=2

GAME="enemy-territory"
MOD_DESC="a class-based teamplay modification"
MOD_NAME="Fortress"
MOD_DIR="etf"
MOD_ICON="etf.xpm"

inherit eutils unpacker games games-mods

HOMEPAGE="http://www.etfgame.com/"
SRC_URI="http://liflg.j0ke.net/files/final/etf_${PV}-english-5.run"

LICENSE="freedist"
KEYWORDS="amd64 x86"
IUSE="dedicated opengl"

QA_TEXTRELS="${GAMES_DATADIR:1}/${GAME}/omnibot_etf.so"

src_unpack() {
	unpack_makeself
	unpack ./etf.tar ./cfgnormal.tar.gz
}

src_prepare() {
	mv -f etf.xpm ${MOD_DIR} || die
	rm -rf bin setup.data
	rm -f *.gz *.xml *.tar LICENSE README* *.sh
}
