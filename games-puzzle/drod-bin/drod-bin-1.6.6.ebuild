# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/drod-bin/drod-bin-1.6.6.ebuild,v 1.10 2012/02/08 21:30:15 vapier Exp $

inherit eutils unpacker games

DESCRIPTION="Deadly Rooms Of Death: face room upon room of deadly things, armed with only a sword and your wits"
HOMEPAGE="http://www.drod.net/"
SRC_URI="mirror://sourceforge/drod/CDROD-${PV}-setup.sh.bin"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="-* ~amd64 x86"
IUSE=""
RESTRICT="strip"

DEPEND=""
RDEPEND="
	x86? (
		x11-libs/libX11
		media-libs/freetype
		media-libs/libsdl
		media-libs/sdl-ttf
		sys-libs/libstdc++-v3
	)
	amd64? (
		app-emulation/emul-linux-x86-xlibs
		app-emulation/emul-linux-x86-sdl
		app-emulation/emul-linux-x86-compat
	)"

S="${WORKDIR}"

src_unpack() {
	unpack_makeself
	GDIR=${GAMES_PREFIX_OPT}/drod
}

src_install() {
	./install.sh -R "${D}" -s "${GDIR}" -rl -pn -o -I \
		|| die "install.sh failed"
	dodir "${GAMES_BINDIR}"
	dosym "${GDIR}/drod" "${GAMES_BINDIR}/drod"

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
