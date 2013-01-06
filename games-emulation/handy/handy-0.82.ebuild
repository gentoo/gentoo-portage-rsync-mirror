# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/handy/handy-0.82.ebuild,v 1.7 2008/05/15 12:35:43 nyhm Exp $

inherit games

MY_RLS="R1"
DESCRIPTION="A Atari Lynx emulator for Linux"
HOMEPAGE="http://sdlemu.ngemu.com/handysdl.php"
SRC_URI="http://sdlemu.ngemu.com/releases/Handy-SDL-${PV}${MY_RLS}.i386.linux-glibc22.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* x86"
RESTRICT="strip"
IUSE=""

RDEPEND="media-libs/libsdl
	sys-libs/zlib
	sys-libs/lib-compat"

S=${WORKDIR}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}
	exeinto "${dir}"
	newexe sdlhandy handy || die "doexe failed"
	dohtml -r docs/*
	games_make_wrapper sdlhandy ./sdlhandy "${dir}" "${dir}"
	games_make_wrapper handy ./handy "${dir}" "${dir}"
	prepgamesdirs
}
