# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/spacetripper-demo/spacetripper-demo-1.ebuild,v 1.15 2012/08/29 13:40:30 tupone Exp $

inherit eutils unpacker games

MY_P="spacetripperdemo"
DESCRIPTION="hardcore arcade shoot-em-up"
HOMEPAGE="http://www.pompomgames.com/"
SRC_URI="http://www.btinternet.com/~bongpig/${MY_P}.sh"

LICENSE="POMPOM"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""
RESTRICT="strip"

RDEPEND="virtual/opengl
	amd64? (
		app-emulation/emul-linux-x86-xlibs
		app-emulation/emul-linux-x86-soundlibs
		app-emulation/emul-linux-x86-compat
		app-emulation/emul-linux-x86-sdl )
	x86? (
		x11-libs/libX11
		x11-libs/libXext )"

S=${WORKDIR}

dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

QA_PREBUILT="${dir}/*"

src_unpack() {
	unpack_makeself
}

src_install() {
	exeinto "${dir}"
	doexe bin/x86/*
	# Remove libSDL since we use the system version and our version doesn't
	# have TEXTRELs in it.
	rm -f "${Ddir}"/libSDL-1.2.so.0.0.5
	sed -i \
		-e "s:XYZZY:${dir}:" "${Ddir}/${MY_P}" \
		|| die "sed failed"

	insinto "${dir}"
	doins -r preview run styles || die "doins failed"
	doins README license.txt icon.xpm
	newicon icon.xpm spacetripper-demo.png

	games_make_wrapper spacetripper-demo ./spacetripperdemo "${dir}" "${dir}"
	make_desktop_entry spacetripper-demo spacetripper-demo spacetripper-demo

	prepgamesdirs
}
