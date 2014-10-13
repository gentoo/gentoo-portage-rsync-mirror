# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/bcs-demo/bcs-demo-1.3.ebuild,v 1.12 2014/10/13 21:09:36 mgorny Exp $

EAPI=5

inherit unpacker games

DESCRIPTION="design and build bridges and then stress test them with trains"
HOMEPAGE="http://www.garagegames.com/pg/product/view.php?id=17"
SRC_URI="ftp://ggdev-1.homelan.com/bcs/bcsdemo_v${PV/./_}.sh.bin
	http://www.highprogrammer.com/alan/pfx2/openal-alan-hack-0.0.1.tar.gz"

LICENSE="BCS"
SLOT="0"
KEYWORDS="-* ~amd64 x86"
IUSE=""
RESTRICT="strip"

RDEPEND="sys-libs/glibc
	|| (
		(
			media-libs/libsdl[abi_x86_32(-)]
			x11-libs/libX11[abi_x86_32(-)]
			x11-libs/libXext[abi_x86_32(-)]
			x11-libs/libXau[abi_x86_32(-)]
			x11-libs/libXdmcp[abi_x86_32(-)]
			virtual/opengl[abi_x86_32(-)]
		)
		amd64? (
			app-emulation/emul-linux-x86-opengl[-abi_x86_32(-)]
			app-emulation/emul-linux-x86-sdl[-abi_x86_32(-)]
			app-emulation/emul-linux-x86-xlibs[-abi_x86_32(-)]
		)
	)"

S=${WORKDIR}

dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}
QA_PREBUILT="${dir:1}/*"

src_unpack() {
	unpack_makeself bcsdemo_v${PV/./_}.sh.bin
	unpack openal-alan-hack-0.0.1.tar.gz
}

src_install() {
	dodir "${dir}" "${GAMES_BINDIR}"

	tar -zxf bcsdemo.tar.gz -C "${Ddir}" || die "extracting bcsdemo.tar.gz"
	rm -f "${Ddir}"/bcs-linux-openal-fixer.sh

	exeinto "${dir}"
#	doexe bin/Linux/x86/rungame.sh
#	exeinto ${dir}/lib
	mv "${Ddir}"/bcs "${Ddir}"/bcs-bin
	newexe libopenal.so.0.0.6 libopenal.so.0
	echo '#!/bin/bash' >> "${Ddir}"/bcs
	echo 'LD_PRELOAD="./libopenal.so.0" ./bcs-bin' >> "${Ddir}"/bcs
	fperms 750 "${dir}"/bcs
	games_make_wrapper bcs-demo ./bcs "${dir}" "${dir}"

	insinto "${dir}"
	doins *.cfg
	dodoc readme*

	prepgamesdirs
}
