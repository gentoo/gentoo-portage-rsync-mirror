# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/swordandsworcery/swordandsworcery-1.02.ebuild,v 1.2 2013/03/22 21:31:44 hasufell Exp $

# TODO: unbundle liblua-5.1 when available for multilib

EAPI=5

inherit eutils games

DESCRIPTION="An exploratory action adventure game with an emphasis on audiovisual style"
HOMEPAGE="http://www.swordandsworcery.com/"
SRC_URI="${PN}_${PV}.tar.gz"

LICENSE="CAPYBARA-EULA LGPL-3"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="bundled-libs"
RESTRICT="bindist fetch"

MYGAMEDIR=${GAMES_PREFIX_OPT}/${PN}
QA_PREBUILT="${MYGAMEDIR#/}/bin/*
	${MYGAMEDIR#/}/lib/*"

# linked to pulseaudio
RDEPEND="
	virtual/opengl
	amd64? (
		app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-opengl
		app-emulation/emul-linux-x86-sdl
		app-emulation/emul-linux-x86-soundlibs[alsa]
		app-emulation/emul-linux-x86-xlibs
	)
	x86? (
		dev-libs/openssl
		media-libs/alsa-lib
		media-libs/flac
		media-libs/libogg
		media-libs/libsndfile
		media-libs/libvorbis
		media-sound/pulseaudio
		sys-libs/zlib
		virtual/glu
		x11-libs/libICE
		x11-libs/libSM
		x11-libs/libX11
		x11-libs/libXau
		x11-libs/libxcb
		x11-libs/libXdmcp
		x11-libs/libXext
		x11-libs/libXi
		x11-libs/libXtst
		!bundled-libs? (
			net-misc/curl
			media-libs/libsdl[X,audio,video,opengl,joystick]
		)
	)"

S=${WORKDIR}

pkg_nofetch() {
	einfo "Please buy & download ${SRC_URI} from:"
	einfo "  ${HOMEPAGE}"
	einfo "and move it to ${DISTDIR}"
}

src_prepare() {
	if ! use bundled-libs ; then
		einfo "removing bundled libs..."
		rm -v lib/libcurl.so* lib/libSDL-1.2.so* \
			lib/libstdc++.so* || die
	fi

	sed \
		-e "s#@GAMEDIR@#${MYGAMEDIR}#" \
		"${FILESDIR}"/${PN}-wrapper > "${T}"/${PN} || die
}

src_install() {
	insinto "${MYGAMEDIR}"
	doins -r bin lib res

	dogamesbin "${T}"/${PN}
	make_desktop_entry ${PN}

	dohtml README.html

	fperms +x "${MYGAMEDIR}"/bin/${PN}
	prepgamesdirs
}
