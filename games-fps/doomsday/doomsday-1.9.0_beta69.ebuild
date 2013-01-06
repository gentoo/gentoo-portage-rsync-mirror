# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/doomsday/doomsday-1.9.0_beta69.ebuild,v 1.7 2011/10/15 14:08:01 xarthisius Exp $

EAPI=2
inherit cmake-utils games

MY_P=deng-1.9.0-beta6.9 # FIXME, this is stupid
DESCRIPTION="A modern gaming engine for Doom, Heretic, and Hexen"
HOMEPAGE="http://www.dengine.net/"
SRC_URI="mirror://sourceforge/deng/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-amd64 ppc x86"
IUSE="openal"

RDEPEND="virtual/opengl
	virtual/glu
	media-libs/libsdl[video]
	media-libs/sdl-mixer
	media-libs/sdl-net
	media-libs/libpng
	net-misc/curl
	openal? ( media-libs/openal )"
DEPEND="${RDEPEND}
	app-arch/zip"

S=${WORKDIR}/${MY_P}/${PN}

PATCHES=( "${FILESDIR}"/${P}-underlink.patch
	"${FILESDIR}"/${P}-png15.patch
)

src_configure() {
	mycmakeargs=(
		-Dbindir="${GAMES_BINDIR}"
		-Ddatadir="${GAMES_DATADIR}"/${PN}
		-Dlibdir="$(games_get_libdir)"/${PN}
		$(cmake-utils_use openal BUILDOPENAL) )

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install

	mv "${D}/${GAMES_DATADIR}"/{${PN}/data/jdoom,doom-data} || die
	dosym "${GAMES_DATADIR}"/doom-data "${GAMES_DATADIR}"/${PN}/data/jdoom || die

	local game
	for game in jdoom jheretic jhexen ; do
		newgamesbin "${FILESDIR}"/wrapper ${game}
		sed -i "s:GAME:${game}:" \
			"${D}/${GAMES_BINDIR}"/${game} \
			|| die "sed ${GAMES_BINDIR}/${game} failed"
	done

	# Make wrappers for the common wads
	local n
	for n in doom doom2 ; do
		games_make_wrapper ${PN}-${n} \
			"jdoom -file \"${GAMES_DATADIR}\"/doom-data/${n}.wad"
	done

	doman engine/doc/${PN}.6
	dodoc engine/doc/*.txt build/README
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "To play the original Doom levels, place doom.wad and/or doom2.wad"
	elog "into ${GAMES_DATADIR}/doom-data"
	elog "Then run doomsday-doom or doomsday-doom2 accordingly."
	elog
	elog "doom1.wad is the shareware demo wad consisting of 1 episode,"
	elog "and doom.wad is the full Doom 1 set of 3 episodes"
	elog "(or 4 in the Final Doom wad)."
	elog
	elog "You can even emerge doom-data and/or freedoom, with the doomsday use"
	elog "flag enabled, to play for free"
}
