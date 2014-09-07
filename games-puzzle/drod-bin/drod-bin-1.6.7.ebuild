# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/drod-bin/drod-bin-1.6.7.ebuild,v 1.6 2014/09/07 15:32:25 ulm Exp $

EAPI=2

inherit eutils unpacker games

DESCRIPTION="Deadly Rooms Of Death: face room upon room of deadly things, armed with only a sword and your wits"
HOMEPAGE="http://www.drod.net/"
#SRC_URI="mirror://sourceforge/drod/CDROD-${PV}-setup.sh.bin"
SRC_URI="mirror://sourceforge/drod/Linux%20Setup/Caravel%20DROD%201.6.7%20Setup/DRODAESetup-1.6.7.run"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="-* ~amd64 x86"
IUSE=""
RESTRICT="strip"

DEPEND=""
RDEPEND="virtual/libstdc++:3.3
	x86? (
		x11-libs/libX11
		media-libs/freetype
		media-libs/libsdl
		media-libs/sdl-ttf
	)
	amd64? (
		app-emulation/emul-linux-x86-xlibs
		app-emulation/emul-linux-x86-sdl
	)"

GDIR=${GAMES_PREFIX_OPT}/drod
QA_PREBUILT="${GDIR:1}/drod-ae.bin
	${GDIR:1}/Libs/*"

S=${WORKDIR}

src_configure() {
	sed "s:%DRODAE_HOME%:${GDIR}:g" bin/Linux/x86/glibc-2.1/drod-ae.in > drod
	chmod a+x drod-ae
}

src_install() {
	insinto "${GDIR}"
	doins -r Data

	exeinto "${GDIR}"
	doexe bin/Linux/x86/glibc-2.1/drod-ae.bin
	dogamesbin drod

	exeinto "${GDIR}"/Libs
	doexe Libs/{libexpat.so.0.5.0,libfmod-3.74.1.so}
	dosym libexpat.so.0.5.0 "${GDIR}"/Libs/libexpat.so.0

	dosym Data/Help "${GDIR}"/Help

	newicon Data/Bitmaps/Icon.bmp ${PN}.bmp
	make_desktop_entry drod "Deadly Rooms of Death" /usr/share/pixmaps/${PN}.bmp

	prepgamesdirs
}

pkg_preinst() {
	games_pkg_preinst
	if [[ -d "${ROOT}${GDIR}/bin/Data" ]] ; then
		mv "${ROOT}${GDIR}"/{bin/Data,Data.backup}
		echo
		ewarn "Your saved games have been backed up to ${GDIR}/Data.backup."
		ewarn "You can restore your game by copying the files to"
		ewarn "~/.caravel/drod-1_6/ like this:"
		ewarn "    mkdir -p ~/.caravel/drod-1_6/"
		ewarn "    cp ${GDIR}/Data.backup/* ~/.caravel/drod-1_6/"
		echo
	fi
}
