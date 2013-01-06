# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/nwmouse/nwmouse-20090906.183839.ebuild,v 1.3 2010/08/17 20:30:47 mr_bones_ Exp $

inherit games

DESCRIPTION="Hardware mouse cursors for Neverwinter Nights"
HOMEPAGE="http://home.roadrunner.com/~nwmovies/"
SRC_URI="http://dev.gentoo.org/~calchan/distfiles/${P}.tar.bz2
	mirror://gentoo/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 x86"
# I've looked at this stuff, and I can't find the problem myself, so I'm just
# removing the warnings.  If someone feels like finding the patch, that would be
# great and I'll gladly include it.
QA_EXECSTACK="${GAMES_PREFIX_OPT:1}/nwn/nwmouse.so"
QA_TEXTRELS="${GAMES_PREFIX_OPT:1}/nwn/nwmouse.so"
IUSE=""
RESTRICT="strip mirror"

RDEPEND="sys-libs/glibc
	dev-libs/elfutils
	games-rpg/nwn-data
	amd64? (
		app-emulation/emul-linux-x86-xlibs
		app-emulation/emul-linux-x86-sdl )
	>=games-rpg/nwn-1.68-r4
	x86? (
		x11-libs/libXcursor
		x11-libs/libXext
		x11-libs/libX11
		media-libs/libsdl )"

dir="${GAMES_PREFIX_OPT}/nwn"

pkg_setup() {
	games_pkg_setup
	elog "This package is pre-compiled so it will work on both x86 and amd64."
}

src_install() {
	# libelf moved to games-rpg/nwn, see bug #210562
	exeinto "${dir}"
	doexe "${PN}.so" || die "Installation failed"
	exeinto "${dir}/${PN}/libdis"
	doexe "libdisasm.so" || die "Installation failed"
	insinto "${dir}/${PN}/cursors"
	doins -r cursors/* || die "Installation failed"
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "When starting nwn the next time, nwmouse will scan the nwmain"
	elog "binary for its hooks, store this information in:"
	elog "  ${dir}/nwmouse.ini"
	elog "and exit. This is normal."
	elog
	elog "You will have to remove this file whenever you update nwn."
}
