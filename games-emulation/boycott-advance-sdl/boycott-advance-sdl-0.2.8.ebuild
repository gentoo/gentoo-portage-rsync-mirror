# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/boycott-advance-sdl/boycott-advance-sdl-0.2.8.ebuild,v 1.5 2013/11/14 21:54:05 mr_bones_ Exp $

inherit games

MY_RLS="R1"
DESCRIPTION="A Gameboy Advance (GBA) emulator for Linux"
HOMEPAGE="http://sdlemu.ngemu.com/basdl.php"
SRC_URI="http://sdlemu.ngemu.com/releases/BoyCottAdvance-SDL-${PV}${MY_RLS}.i386.linux.tar.gz"

KEYWORDS="-* x86"
LICENSE="as-is"
SLOT="0"
RESTRICT="strip"
IUSE=""

RDEPEND="virtual/opengl
	>=media-libs/libsdl-1.2
	sys-libs/lib-compat
	sys-libs/zlib"

S=${WORKDIR}/boyca-sdl

src_install() {
	local dir="${GAMES_PREFIX_OPT}/${PN}"

	exeinto "${dir}"
	doexe boyca         || die "doexe failed"
	insinto "${dir}/roms"
	doins PongFighter/* || die "doins failed (roms)"
	insinto "${dir}"
	doins boyca.cfg     || die "doins failed (cfg)"
	dodoc docs/*        || die "dodoc failed"

	games_make_wrapper boyca ./boyca "${dir}"

	prepgamesdirs
}
