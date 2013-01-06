# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake1-rally/quake1-rally-1.2.ebuild,v 1.5 2005/11/05 22:55:38 vapier Exp $

inherit eutils games

DESCRIPTION="TC which turns Quake into a Rally racing game"
HOMEPAGE="http://www.quakerally.com/"
SRC_URI="mirror://gentoo/qr12.zip
	mirror://gentoo/qrlo1.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=""
DEPEND="app-arch/unzip"

S=${WORKDIR}

src_unpack() {
	echo ">>> Unpacking qr12.zip to ${PWD}"
	unzip -qoLL "${DISTDIR}"/qr12.zip || die "unpacking qr12.zip failed"
	echo ">>> Unpacking qrlo1.zip to ${PWD}"
	unzip -qoLL "${DISTDIR}"/qrlo1.zip || die "unpacking qrlo1.zip failed"
	rm -f button.wav qrally.exe
	cd rally
	edos2unix $(find . -name '*.txt' -o -name '*.cfg')
	mv rally{,.example}.cfg
}

src_install() {
	insinto "${GAMES_DATADIR}/quake1"
	doins -r * || die "doins"
	prepgamesdirs
}
