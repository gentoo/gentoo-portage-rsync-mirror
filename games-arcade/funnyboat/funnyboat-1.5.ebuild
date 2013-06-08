# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/funnyboat/funnyboat-1.5.ebuild,v 1.6 2013/06/08 19:17:58 slyfox Exp $

inherit eutils games

DESCRIPTION="A side scrolling shooter game starring a steamboat on the sea"
HOMEPAGE="http://funnyboat.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.zip"

LICENSE="GPL-2 MIT"
SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-python/pygame-1.6.2
	=dev-lang/python-2*"
DEPEND="app-arch/unzip"

S=${WORKDIR}/${PN}

src_install() {
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r data *.py || die "doins failed"
	dodoc *.txt
	# does not like python3 (fails on os.environ["HOME"])
	games_make_wrapper ${PN} "python2 main.py" "${GAMES_DATADIR}"/${PN}
	newicon data/kuvake.png ${PN}.png
	make_desktop_entry ${PN} "Trip on the Funny Boat"
	prepgamesdirs
}
