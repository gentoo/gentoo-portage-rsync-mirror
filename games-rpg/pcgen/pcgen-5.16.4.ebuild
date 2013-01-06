# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/pcgen/pcgen-5.16.4.ebuild,v 1.5 2011/11/09 02:17:53 mr_bones_ Exp $

EAPI=2
inherit versionator games

MY_PV=$(delete_all_version_separators)
DESCRIPTION="D&D character generator"
HOMEPAGE="http://pcgen.sourceforge.net/"
SRC_URI="mirror://sourceforge/pcgen/pcgen${MY_PV}_full.zip"

LICENSE="LGPL-2 OGL-1.0a"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-java/sun-jdk" # only works with the sun jdk (bug #353471)
DEPEND="app-arch/unzip"

S=${WORKDIR}/pcgen${MY_PV}

src_prepare() {
	rm -f *.bat
	sed -i "/dirname/ c\cd \"${GAMES_DATADIR}\/${PN}\"" pcgen.sh \
		|| die "sed pcgen.sh failed"
	mv -f pcgen.sh "${T}"/${PN}
}

src_install() {
	dogamesbin "${T}"/${PN} || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r * || die "doins failed"
	keepdir "${GAMES_DATADIR}"/${PN}/characters
	prepgamesdirs
}
