# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/legends/legends-0.4.1.43.ebuild,v 1.6 2012/02/05 06:03:26 vapier Exp $

inherit eutils unpacker games

MY_P=${PN}_linux-${PV}
dir=${GAMES_PREFIX_OPT}/${PN}

DESCRIPTION="Fast-paced first-person-shooter online multiplayer game, similar to Tribes"
HOMEPAGE="http://legendsthegame.net/"
SRC_URI="http://legendsthegame.net/files/${MY_P}.run
	mirror://gentoo/${PN}.png"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* x86"
IUSE="dedicated"
RESTRICT="strip"

QA_TEXTRELS="${dir:1}/libSDL-1.3.so.0"

DEPEND=""
RDEPEND=">=media-libs/libsdl-1.2
	media-libs/libogg
	media-libs/libvorbis
	media-libs/openal
	sys-libs/glibc
	amd64? ( >=app-emulation/emul-linux-x86-sdl-2.1
		>=app-emulation/emul-linux-x86-soundlibs-2.1 )
	media-fonts/font-adobe-75dpi"

S=${WORKDIR}

src_unpack() {
	unpack_makeself ${MY_P}.run
	cd "${S}"

	# keep libSDL-1.3.so because legends requires it as of 0.4.0, and
	# 1.2.6 is highest in portage
	# rm libSDL-*.so*
	rm runlegends libSDL-1.2.so.0 libopenal.so libogg.so.0 libvorbis.so.0 *.DLL
}

src_install() {
	insinto "${dir}"
	doins -r * || die "doins * failed"

	rm "${D}/${dir}/"/{lindedicated,LinLegends,*.so.0}
	exeinto "${dir}"
	doexe lindedicated LinLegends *.so.0 || die "doexe failed"

	games_make_wrapper ${PN} "./LinLegends" "${dir}" "${dir}"
	if use dedicated ; then
		games_make_wrapper ${PN}-ded "./lindedicated" "${dir}" "${dir}"
	fi

	doicon "${DISTDIR}"/${PN}.png || die "doicon failed"
	make_desktop_entry legends "Legends"

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	ewarn "Version ${PV} of ${PN} may give problems if there are"
	ewarn "config-files from earlier versions.  Removing the ~/.legends dir"
	ewarn "and restarting will solve this."
	echo
}
