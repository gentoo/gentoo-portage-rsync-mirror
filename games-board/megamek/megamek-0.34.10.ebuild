# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/megamek/megamek-0.34.10.ebuild,v 1.3 2012/12/07 21:40:34 ago Exp $

EAPI=2
inherit eutils java-pkg-2 java-ant-2 games

DESCRIPTION="an unofficial, online version of the Classic BattleTech board game"
HOMEPAGE="http://megamek.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/MegaMek-v${PV}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND=">=virtual/jdk-1.5
	app-arch/unzip"
RDEPEND=">=virtual/jre-1.5"

S=${WORKDIR}

pkg_setup() {
	games_pkg_setup
	java-pkg-2_pkg_setup
}

src_prepare() {
	rm -v *.jar || die
	edos2unix startup.sh
	sed -i \
		-e "s:XmX:Xmx:" \
		-e "s:/usr/share/java:${GAMES_DATADIR}/${PN}:" \
		-e "s:/usr/share/MegaMek:${GAMES_DATADIR}/${PN}:" \
		startup.sh || die "sed failed"
	java-pkg-2_src_prepare
}

src_compile() {
	eant || die
}

src_install() {
	newgamesbin startup.sh ${PN} || die "newgamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r data docs l10n lib mmconf *.jar readme* || die "doins failed"
	dodoc HACKING readme.txt || die
	make_desktop_entry ${PN} MegaMek /usr/share/pixmaps/${PN}.gif
	newicon data/images/misc/megamek-icon.gif ${PN}.gif
	prepgamesdirs
}
