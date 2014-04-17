# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/handy/handy-0.82.ebuild,v 1.8 2014/04/17 07:00:46 ulm Exp $

inherit games

MY_RLS="R1"
DESCRIPTION="A Atari Lynx emulator for Linux"
HOMEPAGE="http://sdlemu.ngemu.com/handysdl.php"
SRC_URI="http://sdlemu.ngemu.com/releases/Handy-SDL-${PV}${MY_RLS}.i386.linux-glibc22.tar.bz2"

# Closed source, but docs/Handy.html says that it "does not contain
# any copyrighted materials"
LICENSE="public-domain no-source-code"
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
