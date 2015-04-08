# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake1-ctf/quake1-ctf-4.0.ebuild,v 1.4 2014/05/04 17:50:53 ulm Exp $

inherit eutils games

DESCRIPTION="The original Three Wave Capture The Flag"
HOMEPAGE="http://www.threewave.com/"
SRC_URI="http://www.threewave.com/quake1/files/3wctf301.zip
	http://www.threewave.com/quake1/files/3wctfc40.zip
	http://www.threewave.com/quake1/files/ctfepc14.zip
	http://www.threewave.com/quake1/files/alst101c.zip
	http://www.threewave.com/quake1/files/alst110u.zip"
#	dedicated? ( http://www.threewave.com/quake1/files/alst110s.zip )
#	dedicated? ( http://www.threewave.com/quake1/files/3wave421d.zip )

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RESTRICT="mirror bindist"

RDEPEND=""
DEPEND="app-arch/unzip"

S=${WORKDIR}

src_unpack() {
	mkdir ctf
	cd ctf
	echo ">>> Unpacking 3wctf301.zip to ${PWD}"
	unzip -qoL "${DISTDIR}"/3wctf301.zip || die "unpacking 3wctf301.zip failed"
	mv readme.txt readme-301.txt
	echo ">>> Unpacking 3wctfc40.zip to ${PWD}"
	unzip -qoL "${DISTDIR}"/3wctfc40.zip || die "unpacking 3wctfc40.zip failed"
	mv readme.txt readme-40.txt
	echo ">>> Unpacking ctfepc14.zip to ${PWD}"
	unzip -qoL "${DISTDIR}"/ctfepc14.zip || die "unpacking ctfepc14.zip failed"
	cd ..
	echo ">>> Unpacking alst101c.zip to ${PWD}"
	unzip -qoL "${DISTDIR}"/alst101c.zip || die "unpacking alst101c.zip failed"
	mv ctf/readme.txt ctf/readme-alst101c.txt
	echo ">>> Unpacking alst110u.zip to ${PWD}"
	unzip -qoL "${DISTDIR}"/alst110u.zip || die "unpacking alst110u.zip failed"
	mv ctf/readme.txt ctf/readme-alst110u.txt
	rmdir maps progs readme
}

src_install() {
	insinto "${GAMES_DATADIR}/quake1"
	doins -r * || die
	prepgamesdirs
}
