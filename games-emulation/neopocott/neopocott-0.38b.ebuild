# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/neopocott/neopocott-0.38b.ebuild,v 1.9 2014/05/13 06:30:06 ulm Exp $

inherit games

MY_RLS="R2.1"
DESCRIPTION="A NeoGeo Pocket emulator for Linux"
HOMEPAGE="http://sdlemu.ngemu.com/neopocottsdl.php"
SRC_URI="http://sdlemu.ngemu.com/releases/NeoPocott-SDL-${PV}${MY_RLS}.i386.linux-glibc22.tar.bz2"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""
RESTRICT="mirror bindist strip"

RDEPEND="media-libs/libsdl
	sys-libs/zlib"

S=${WORKDIR}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}
	exeinto "${dir}"
	doexe neopocott || die "doexe failed"
	dodoc doc/*
	games_make_wrapper neopocott ./neopocott "${dir}" "${dir}"
	prepgamesdirs
}
