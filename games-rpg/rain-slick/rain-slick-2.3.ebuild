# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/rain-slick/rain-slick-2.3.ebuild,v 1.9 2015/02/11 03:42:24 patrick Exp $

EAPI=5

inherit eutils games

EP=${PV:0:1}
REV=${PV:2:1}

DESCRIPTION="On the Rain-Slick Precipice of Darkness, Episode Two"
HOMEPAGE="http://rainslick.com/"
SRC_URI="http://a.pa-cdn.com/greenhouse/rainslickep${EP}_linux_r${REV}.tgz"

LICENSE="Rain-Slick LGPL-2.1+ BSD BSD-2 fmod MIT"
SLOT="${EP}"
KEYWORDS="amd64 x86"
IUSE=""
RESTRICT="bindist mirror strip"

RDEPEND="sys-libs/glibc
	|| (
		(
			x11-libs/libX11[abi_x86_32(-)]
			x11-libs/libXext[abi_x86_32(-)]
			x11-libs/libXrandr[abi_x86_32(-)]
			virtual/opengl[abi_x86_32(-)]
		)
		amd64? (
			app-emulation/emul-linux-x86-opengl[-abi_x86_32(-)]
			app-emulation/emul-linux-x86-xlibs[-abi_x86_32(-)]
		)
	)
"
DEPEND=""

dir="${GAMES_PREFIX_OPT}/${PN}/ep${EP}"
QA_PREBUILT="${dir:1}/RainSlickEp2_bin
	${dir:1}/linux_libs/*"

S=${WORKDIR}/RainSlickEp${EP}

src_install() {
	dodir "${dir}"
	cp -pPR * "${D}/${dir}/" || die
	games_make_wrapper RainSlickEp${EP} "${dir}/RainSlickEp${EP}"
	newicon rainslick.png ${PN}-${EP}.png
	make_desktop_entry RainSlickEp${EP} "Rain-Slick Precipice of Darkness (Ep${EP})" ${PN}-${EP}
	prepgamesdirs
}
