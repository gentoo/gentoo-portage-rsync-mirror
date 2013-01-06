# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/psemu-eternalspu/psemu-eternalspu-1.41-r2.ebuild,v 1.4 2007/04/09 16:52:47 nyhm Exp $

inherit games

DESCRIPTION="PSEmu Eternal SPU"
HOMEPAGE="http://www1.odn.ne.jp/psx-alternative/"
SRC_URI="http://www1.odn.ne.jp/psx-alternative/download/spuEternal${PV//.}_linux.tgz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86"
IUSE=""
RESTRICT="strip"

RDEPEND="x11-libs/libXext
	sys-libs/lib-compat"

S=${WORKDIR}

src_install() {
	exeinto "$(games_get_libdir)"/psemu/plugins
	doexe libspuEternal.so.* || die "doexe failed"
	dodoc *.txt
	prepgamesdirs
}
