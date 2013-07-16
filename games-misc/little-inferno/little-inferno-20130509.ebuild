# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/little-inferno/little-inferno-20130509.ebuild,v 1.2 2013/07/16 16:21:35 hasufell Exp $

EAPI=5

inherit eutils gnome2-utils unpacker games

DESCRIPTION="Throw your toys into your fire, and play with them as they burn"
HOMEPAGE="http://tomorrowcorporation.com/"
SRC_URI="LittleInferno-${PV}.sh"

LICENSE="Gameplay-Group-EULA"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="bundled-libs"
RESTRICT="bindist fetch bundled-libs? ( splitdebug )"

MYGAMEDIR=${GAMES_PREFIX_OPT}/${PN}
QA_PREBUILT="${MYGAMEDIR#/}/LittleInferno.bin.x86
	${MYGAMEDIR#/}/lib/*"

RDEPEND="
	virtual/opengl
	amd64? (
		app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-xlibs
		!bundled-libs? (
			app-emulation/emul-linux-x86-sdl
			app-emulation/emul-linux-x86-soundlibs
		)
	)
	x86? (
		net-misc/curl
		x11-libs/libX11
		!bundled-libs? (
			media-libs/libogg
			media-libs/libvorbis
			media-libs/openal
		)
	)"
DEPEND="app-arch/xz-utils"

src_unpack() {
	unpack_makeself ${A}

	mkdir ${P} || die
	cd ${P} || die

	local i
	for i in instarchive_{,linux_}all ; do
		mv ../"${i}" ../"${i}".tar.xz || die
		unpack ./../"${i}".tar.xz
	done
}

src_prepare() {
	if use !bundled-libs ; then
		rm -rv lib || die
	fi
}

src_install() {
	insinto "${MYGAMEDIR}"
	doins -r *

	doicon -s 128 LittleInferno.png
	make_desktop_entry ${PN} "Little Inferno" LittleInferno
	games_make_wrapper ${PN} "./LittleInferno.bin.x86" "${MYGAMEDIR}" "${MYGAMEDIR}/lib"

	fperms +x "${MYGAMEDIR}"/LittleInferno.bin.x86

	prepgamesdirs
}

pkg_preinst() {
	games_pkg_preinst
	gnome2_icon_savelist
}

pkg_postinst() {
	games_pkg_postinst
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
