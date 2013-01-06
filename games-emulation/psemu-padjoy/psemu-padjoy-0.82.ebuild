# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/psemu-padjoy/psemu-padjoy-0.82.ebuild,v 1.7 2007/04/09 17:00:56 nyhm Exp $

inherit games

DESCRIPTION="PSEmu plugin to use joysticks/gamepads in PSX-emulators"
HOMEPAGE="http://www.ammoq.com/"
SRC_URI="http://members.chello.at/erich.kitzmueller/ammoq/padJoy${PV//.}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

DEPEND="=x11-libs/gtk+-1*"

S=${WORKDIR}/padJoy/src

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "s:-O2 -fomit-frame-pointer:${CFLAGS}:" Makefile \
		|| die "sed failed"
}

src_install() {
	exeinto "$(games_get_libdir)"/psemu/plugins
	doexe libpadJoy-* || die "doexe failed"
	exeinto "$(games_get_libdir)"/psemu/cfg
	doexe cfgPadJoy || die "doexe cfgPadJoy failed"
	dodoc ../readme.txt
	prepgamesdirs
}
