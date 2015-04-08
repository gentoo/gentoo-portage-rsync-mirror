# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/searchtool/searchtool-0.4.4.ebuild,v 1.10 2007/11/12 23:11:31 opfer Exp $

inherit java-pkg-2 java-ant-2 games

DESCRIPTION="server browser for Internet games"
HOMEPAGE="http://searchtool.sourceforge.net/"
SRC_URI="mirror://sourceforge/searchtool/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

DEPEND=">=virtual/jdk-1.4"
RDEPEND=">=virtual/jre-1.4"

S=${WORKDIR}/${PN}
JAVA_PKG_FILTER_COMPILER="jikes"

pkg_setup() {
	games_pkg_setup
	java-pkg-2_pkg_setup
}

src_compile() {
	eant || die
}

src_install() {
	games_make_wrapper ${PN} "java -jar ${P}.jar" "${GAMES_DATADIR}/${PN}"
	insinto "${GAMES_DATADIR}/${PN}"
	doins ${P}.jar || die "doins failed"
	dodoc README || die
	prepgamesdirs
}
