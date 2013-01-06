# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/xbattleai/xbattleai-1.2.2-r1.ebuild,v 1.3 2009/10/25 15:26:20 maekke Exp $

EAPI=2
inherit eutils games

DESCRIPTION="A multi-player game of strategy and coordination"
HOMEPAGE="http://www.lysator.liu.se/~mbrx/XBattleAI/index.html"
SRC_URI="http://www.lysator.liu.se/~mbrx/XBattleAI/${P}.tgz"

LICENSE="xbattle"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

# Since this uses similar code and the same binary name as the original XBattle,
# we want to make sure you can't install both at the same time
RDEPEND="x11-libs/libXext
	x11-libs/libX11
	dev-lang/tcl
	dev-lang/tk
	!games-strategy/xbattle"
DEPEND="${RDEPEND}
	x11-proto/xproto
	app-text/rman
	x11-misc/imake"

src_prepare() {
	rm -f xbcs/foo.xbc~
	epatch "${FILESDIR}"/${P}-sandbox.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	mv "${D}/${GAMES_BINDIR}"/{,xb_}gauntletCampaign
	dodoc CONTRIBUTORS README README.AI TODO xbattle.dot
	prepgamesdirs
}
