# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/mastergear-bin/mastergear-bin-2.0.ebuild,v 1.5 2014/04/19 11:10:22 ulm Exp $

inherit games

DESCRIPTION="SEGA Master System / Game Gear emulator"
HOMEPAGE="http://fms.komkon.org/MG/"
SRC_URI="http://fms.komkon.org/MG/MG${PV/\./}-Linux-80x86-bin.tar.Z"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="x86"
IUSE=""
RESTRICT="mirror bindist strip"

RDEPEND="x11-libs/libXext
	sys-libs/zlib"

S=${WORKDIR}

src_install() {
	dogamesbin mg || die "dogamesbin failed"
	insinto /usr/share/doc/${PF}
	doins CART.ROM SF7000.ROM
	dohtml MG.html
	prepgamesdirs
}
