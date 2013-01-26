# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/etqw-demo/etqw-demo-2.0_p1.ebuild,v 1.4 2013/01/26 21:03:38 tupone Exp $

inherit eutils versionator games

MY_MAJOR=$(get_major_version)
MY_REV=$(get_version_component_range 3)
MY_BODY="ETQW-demo${MY_MAJOR}-client-full.r${MY_REV/p/}.x86"

DESCRIPTION="Enemy Territory: Quake Wars demo"
HOMEPAGE="http://zerowing.idsoftware.com/linux/etqw/"
SRC_URI="mirror://idsoftware/etqw/${MY_BODY}.run"

# See copyrights.txt
LICENSE="ETQW"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="strip mirror"

DEPEND="app-arch/unzip"
RDEPEND="virtual/opengl
	x86? (
		media-libs/libsdl
		x11-libs/libX11
		x11-libs/libXau
		x11-libs/libXdmcp
		x11-libs/libXext )
	amd64? ( >=app-emulation/emul-linux-x86-sdl-20071114 )"

S=${WORKDIR}
dir=${GAMES_PREFIX_OPT}/${PN}

QA_PREBUILT="${dir:1}/guis/libmojosetupgui_ncurses.so
	${dir:1}/data/*
	${dir:1}/data/pb/*.so"

src_unpack() {
	einfo "Ignore 'extra bytes' message from unzip"
	unzip -q "${DISTDIR}/${A}"
	# exit status of 1 should just be warnings, not corrupt archive
	[[ $? -eq 0 || $? -eq 1 ]] || die "unpacking failed"
}

src_install() {
	insinto "${dir}"
	doins -r * || die "doins"

	cd data
	exeinto "${dir}"/data
	doexe etqw *.x86 etqw-* lib* *.sh || die "doexe"

	games_make_wrapper ${PN} ./etqw.x86 "${dir}"/data "${dir}"/data
	# Matches with desktop entry for enemy-territory-truecombat
	make_desktop_entry ${PN} "Enemy Territory - Quake Wars (Demo)"

	games_make_wrapper ${PN}-ded ./etqwded.x86 "${dir}"/data "${dir}"/data

	prepgamesdirs
}
