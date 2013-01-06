# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/spaz/spaz-1.605.ebuild,v 1.1 2012/09/27 08:17:05 pinkbyte Exp $

EAPI=4

inherit games

DESCRIPTION="Space Pirates and Zombies"
HOMEPAGE="http://spacepiratesandzombies.com"
SRC_URI="${PN}-linux-humblebundle-09182012-bin"
LICENSE="LOKI-EULA"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="alsa pulseaudio"
RESTRICT="fetch strip"

DEPEND="app-arch/unzip"
RDEPEND="amd64? ( app-emulation/emul-linux-x86-sdl )
	x86? (
		media-libs/openal[alsa?,pulseaudio?]
		media-libs/libsdl
	)
	"

S="${WORKDIR}"/data

QA_PREBUILT="opt/spaz/SPAZ"

src_unpack() {
	unzip -q "${DISTDIR}/${PN}-linux-humblebundle-09182012-bin"
}

src_install() {
	local dir="${GAMES_PREFIX_OPT}/${PN}"

	insinto "${dir}"
	exeinto "${dir}"
	doexe SPAZ
	doins -r common game mods
	doins audio.so
	newicon SPAZ.png spaz.png
	dodoc README-linux.txt

	games_make_wrapper ${PN} ./SPAZ "${dir}" "${dir}"
	make_desktop_entry ${PN} "Space Pirates and Zombies" ${PN}

	prepgamesdirs
}
