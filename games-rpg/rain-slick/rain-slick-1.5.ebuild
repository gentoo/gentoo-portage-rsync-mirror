# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/rain-slick/rain-slick-1.5.ebuild,v 1.5 2013/04/27 17:26:33 ulm Exp $

inherit eutils games

EP=${PV:0:1}
REV=${PV:2:1}

DESCRIPTION="On the Rain-Slick Precipice of Darkness, Episode One"
HOMEPAGE="http://rainslick.com/"
SRC_URI="http://a.pa-cdn.com/greenhouse/rainslickep${EP}_linux_r${REV}.tgz"

LICENSE="Rain-Slick LGPL-2.1+ BSD BSD-2 fmod"
SLOT="${EP}"
KEYWORDS="amd64 x86"
IUSE=""
RESTRICT="bindist mirror strip"

RDEPEND="sys-libs/glibc
	virtual/opengl
	x11-libs/libXrandr
	x11-libs/libX11
	x11-libs/libXext
	amd64? (
		app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-xlibs
	)"

S=${WORKDIR}/rainslickep${EP}

src_install() {
	local dir="${GAMES_PREFIX_OPT}/${PN}/ep${EP}"
	dodir "${dir}"
	cp -pPR * "${D}/${dir}/" || die
	games_make_wrapper RainSlickEp${EP} "${dir}/RainSlickEp${EP}" || die
	newicon rainslick.png ${PN}-${EP}.png || die
	make_desktop_entry RainSlickEp${EP} "Rain-Slick Precipice of Darkness (Ep${EP})" ${PN}-${EP}
	prepgamesdirs
}
