# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/darwinia-demo/darwinia-demo-1.3.0.ebuild,v 1.12 2014/08/10 21:20:44 slyfox Exp $

inherit eutils unpacker games

DESCRIPTION="Darwinia, the hyped indie game of the year. By the Uplink creators"
HOMEPAGE="http://www.darwinia.co.uk/downloads/demo_linux.html"
SRC_URI="http://www.introversion.co.uk/darwinia/downloads/${PN}2-${PV}.sh"

LICENSE="Introversion"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""
RESTRICT="mirror strip"

RDEPEND="
	sys-libs/glibc
	sys-devel/gcc
	x86? (
		virtual/opengl
		virtual/glu
		media-libs/libsdl
		media-libs/libvorbis )
	amd64? (
		app-emulation/emul-linux-x86-xlibs
		app-emulation/emul-linux-x86-medialibs
		app-emulation/emul-linux-x86-compat )"

S=${WORKDIR}

dir=${GAMES_PREFIX_OPT}/${PN}

src_unpack() {
	unpack_makeself
}

src_install() {
	exeinto "${dir}/lib"
	insinto "${dir}/lib"

	doexe lib/{darwinia.bin.x86,open-www.sh} || die "copying executables"
	doins lib/{sounds,main,language}.dat || die "copying data files"

	insinto "${dir}"
	dodoc README || die "copying docs"

	exeinto "${dir}"
	doexe bin/Linux/x86/darwinia || die "doexe failed"

	games_make_wrapper darwinia-demo ./darwinia "${dir}" "${dir}"
	newicon darwinian.png ${PN}.png
	make_desktop_entry darwinia-demo "Darwinia (Demo)"
	prepgamesdirs
}
