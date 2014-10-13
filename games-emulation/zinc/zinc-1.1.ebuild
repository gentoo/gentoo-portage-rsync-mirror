# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/zinc/zinc-1.1.ebuild,v 1.9 2014/10/13 10:42:32 mgorny Exp $

EAPI=5
inherit games

DESCRIPTION="An x86 binary-only emulator for the Sony ZN-1, ZN-2, and Namco System 11 arcade systems"
HOMEPAGE="http://caesar.logiqx.com/php/emulator.php?id=zinc_linux"
SRC_URI="http://caesar.logiqx.com/zips/emus/linux/zinc_linux/${P//[-.]/}-lnx.tar.bz2"

LICENSE="freedist"
SLOT="0"
KEYWORDS="-* ~amd64 x86"
IUSE=""
RESTRICT="strip"
QA_PREBUILT="${GAMES_PREFIX_OPT:1}/bin/zinc /usr/lib*/*.so"

RDEPEND="
	|| (
		(
			x11-libs/libXext[abi_x86_32(-)]
			virtual/opengl[abi_x86_32(-)]
		)
		amd64? (
			app-emulation/emul-linux-x86-opengl[-abi_x86_32(-)]
			app-emulation/emul-linux-x86-xlibs[-abi_x86_32(-)]
		)
	)"

S=${WORKDIR}/zinc

src_install() {
	exeinto "${GAMES_PREFIX_OPT}"/bin
	doexe zinc
	dolib.so libcontrolznc.so librendererznc.so libsoundznc.so libs11player.so
	dodoc readme.txt
	prepgamesdirs
}
