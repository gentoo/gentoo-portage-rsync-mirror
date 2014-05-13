# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/boycott-advance-sdl/boycott-advance-sdl-0.2.8.ebuild,v 1.6 2014/05/13 06:29:34 ulm Exp $

inherit games

MY_RLS="R1"
DESCRIPTION="A Gameboy Advance (GBA) emulator for Linux"
HOMEPAGE="http://sdlemu.ngemu.com/basdl.php"
SRC_URI="http://sdlemu.ngemu.com/releases/BoyCottAdvance-SDL-${PV}${MY_RLS}.i386.linux.tar.gz"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""
RESTRICT="mirror bindist strip"

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
