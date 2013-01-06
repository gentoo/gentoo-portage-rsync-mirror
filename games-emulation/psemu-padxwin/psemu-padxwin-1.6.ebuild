# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/psemu-padxwin/psemu-padxwin-1.6.ebuild,v 1.8 2007/04/09 17:02:28 nyhm Exp $

inherit eutils games

DESCRIPTION="PSEmu plugin to use the keyboard as a gamepad"
HOMEPAGE="http://www.pcsx.net/"
SRC_URI="http://linuzappz.pcsx.net/downloads/padXwin-${PV}.tgz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${PV}-makefile-cflags.patch
	sed -i '/strip/d' src/Makefile || die "sed failed"
}

src_compile() {
	cd src
	emake OPTFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dodoc ReadMe.txt
	cd src
	exeinto "$(games_get_libdir)"/psemu/plugins
	doexe libpadXwin-* || die "doexe failed"
	exeinto "$(games_get_libdir)"/psemu/cfg
	doexe cfgPadXwin || die "doexe failed"
	prepgamesdirs
}
