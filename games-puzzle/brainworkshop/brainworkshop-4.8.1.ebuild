# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/brainworkshop/brainworkshop-4.8.1.ebuild,v 1.4 2011/03/04 12:26:13 tomka Exp $

EAPI=2
inherit eutils games

DESCRIPTION="Short-term-memory training N-Back game"
HOMEPAGE="http://brainworkshop.sourceforge.net/"
SRC_URI="mirror://sourceforge/brainworkshop/${P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-python/pyopenal
	|| ( >=dev-python/pyglet-1.1.4[openal]
		 >=dev-python/pyglet-1.1.4[alsa] )"
DEPEND="app-arch/unzip"

src_unpack() {
	unzip -q "${DISTDIR}"/${P}.zip
	mv ${PN} ${P}
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-fix-paths.patch || die "epatch failed"
	edos2unix ${PN}.pyw
}

src_install() {
	newgamesbin ${PN}.pyw ${PN} || die
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r res/* || die "doins failed"
	dodoc Readme.txt data/Readme-stats.txt
	newicon res/misc/brain/brain.png ${PN}.png
	make_desktop_entry ${PN} "Brain Workshop"
	prepgamesdirs
}
