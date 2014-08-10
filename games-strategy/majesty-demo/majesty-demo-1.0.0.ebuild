# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/majesty-demo/majesty-demo-1.0.0.ebuild,v 1.15 2014/08/10 21:21:00 slyfox Exp $

EAPI=4
inherit eutils unpacker games

DESCRIPTION="Control your own kingdom in this simulation"
HOMEPAGE="http://www.linuxgamepublishing.com/info.php?id=8&"
SRC_URI="http://demos.linuxgamepublishing.com/majesty/majesty_demo.run"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""
RESTRICT="mirror bindist strip"

RDEPEND="sys-libs/glibc
	x86? (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXau
		x11-libs/libXdmcp )
	ppc? (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXau
		x11-libs/libXdmcp )
	amd64? (
		app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-xlibs )"

S=${WORKDIR}

dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}
QA_PREBUILT="${dir:1}/maj_demo"

src_install() {
	dodoc README*
	insinto "${dir}"
	exeinto "${dir}"
	doins -r data quests
	doins majesty.{bmp,xpm} majestysite.url
	cp "${S}"/majesty.xpm "${S}"/majesty-demo.xpm
	doicon majesty-demo.xpm
	# I am only installing the static version for now
	if use x86 || use amd64; then
		doexe bin/Linux/x86/glibc-2.1/maj_demo
	elif use ppc; then
		doexe bin/Linux/ppc/glibc-2.1/maj_demo
	fi
	games_make_wrapper maj_demo ./maj_demo "${dir}" "${dir}"
	prepgamesdirs
	make_desktop_entry maj_demo "Majesty (Demo)" ${PN}
}
