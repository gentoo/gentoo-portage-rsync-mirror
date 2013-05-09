# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/dynamitejack/dynamitejack-1.0.23.ebuild,v 1.3 2013/05/09 19:46:06 hasufell Exp $

# TODO: icon

EAPI=5

inherit eutils games

DESCRIPTION="A stealth game with bombs in glorious 2D"
HOMEPAGE="http://www.galcon.com/dynamitejack/"
SRC_URI="${P}.tgz"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
RESTRICT="bindist fetch splitdebug"

MYGAMEDIR=${GAMES_PREFIX_OPT}/${PN}
QA_PREBUILT="${MYGAMEDIR#/}/bin/*"

# linked to pulseaudio
RDEPEND="
	virtual/opengl
	amd64? (
		app-emulation/emul-linux-x86-opengl
		app-emulation/emul-linux-x86-sdl
		app-emulation/emul-linux-x86-soundlibs[alsa]
		app-emulation/emul-linux-x86-xlibs
	)
	x86? (
		media-libs/alsa-lib
		media-libs/flac
		media-libs/libogg
		media-libs/libsdl[X,audio,joystick,opengl,video]
		media-libs/libsndfile
		media-libs/libvorbis
		media-sound/pulseaudio
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
	)"

S=${WORKDIR}/${PN}

pkg_nofetch() {
	einfo "Please buy & download ${SRC_URI} from:"
	einfo "  ${HOMEPAGE}"
	einfo "and move it to ${DISTDIR}"
}

src_prepare() {
	rm run_me || die
	mv LINUX.txt "${T}"/ || die
}

src_install() {
	dodoc "${T}"/LINUX.txt

	insinto "${MYGAMEDIR}"
	doins -r *

	games_make_wrapper ${PN} "./main" "${MYGAMEDIR}/bin"
	make_desktop_entry ${PN}

	fperms +x "${MYGAMEDIR}"/bin/main
	prepgamesdirs
}
