# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/d2x-rebirth/d2x-rebirth-0.57.3.ebuild,v 1.2 2013/02/06 21:52:39 hasufell Exp $

EAPI=5

inherit eutils scons-utils games

DV=2
MY_P=${PN}_v${PV}-src
DESCRIPTION="Descent Rebirth - enhanced Descent ${DV} engine"
HOMEPAGE="http://www.dxx-rebirth.com/"
SRC_URI="mirror://sourceforge/dxx-rebirth/${MY_P}.tar.gz
	opl3-musicpack? ( http://www.dxx-rebirth.com/download/dxx/res/d${DV}xr-opl3-music.zip )
	sc55-musicpack? ( http://www.dxx-rebirth.com/download/dxx/res/d${DV}xr-sc55-music.zip )
	linguas_de? ( http://www.dxx-rebirth.com/download/dxx/res/d${DV}xr-briefings-ger.zip )"

LICENSE="D1X GPL-2 public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cdinstall debug demo ipv6 linguas_de +music opengl opl3-musicpack sc55-musicpack"
REQUIRED_USE="?? ( opl3-musicpack sc55-musicpack )
	opl3-musicpack? ( music )
	sc55-musicpack? ( music )"

RDEPEND="dev-games/physfs[hog,mvl,zip]
	media-libs/libsdl[X,audio,joystick,opengl?,video]
	music? (
		media-libs/sdl-mixer[timidity,vorbis]
	)
	opengl? (
		virtual/opengl
		virtual/glu
	)"
DEPEND="${RDEPEND}
	app-arch/unzip"
PDEPEND="cdinstall? ( games-action/descent2-data )
	demo? ( games-action/descent2-demodata )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${MY_P}.tar.gz
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-flags.patch

	DOCS=( {CHANGELOG,INSTALL,README,RELEASE-NOTES}.txt )
	edos2unix ${DOCS[@]}
}

src_compile() {
	escons \
		verbosebuild=1 \
		sharepath="${GAMES_DATADIR}/d${DV}x" \
		$(use_scons ipv6) \
		$(use_scons music sdlmixer) \
		$(use_scons debug) \
		$(use_scons opengl) \
		|| die
}

src_install() {
	dodoc ${DOCS[@]}

	insinto "${GAMES_DATADIR}/d${DV}x"

	# None of the following zip files need to be extracted.
	use linguas_de && doins "${DISTDIR}"/d${DV}xr-briefings-ger.zip
	use opl3-musicpack && doins "${DISTDIR}"/d${DV}xr-opl3-music.zip
	use sc55-musicpack && doins "${DISTDIR}"/d${DV}xr-sc55-music.zip

	doicon ${PN}.xpm

	dogamesbin ${PN}
	make_desktop_entry ${PN} "Descent ${DV} Rebirth"
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	if ! use cdinstall ; then
		echo
		elog "To play the full game enable USE=\"cdinstall\" or manually "
		elog "copy the files to ${GAMES_DATADIR}/d${DV}x."
		elog "See /usr/share/doc/${PF}/INSTALL.txt for details."
		echo
	fi
}
