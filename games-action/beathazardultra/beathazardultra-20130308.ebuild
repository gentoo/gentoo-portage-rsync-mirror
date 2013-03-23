# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/beathazardultra/beathazardultra-20130308.ebuild,v 1.3 2013/03/23 21:23:50 hasufell Exp $

# TODO: unbundle allegro on amd64 when multilib support

EAPI=5

inherit eutils unpacker games

DESCRIPTION="Intense music-driven arcade shooter powered by your music"
HOMEPAGE="http://www.coldbeamgames.com/"
SRC_URI="beathazard-installer_03-08-13"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="bundled-libs"
RESTRICT="bindist fetch"

MYGAMEDIR=${GAMES_PREFIX_OPT}/${PN}
QA_PREBUILT="${MYGAMEDIR#/}/BeatHazard_Linux2
	${MYGAMEDIR#/}/hge_lib/*"

DEPEND="app-arch/unzip"
RDEPEND="
	virtual/opengl
	amd64? (
		app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-gtklibs
		app-emulation/emul-linux-x86-xlibs
	)
	x86? (
		x11-libs/libX11
		x11-libs/libXcursor
		x11-libs/libXinerama
		x11-libs/libXrandr
		!bundled-libs? (
			media-libs/allegro:5
			media-libs/libpng:1.2
			virtual/jpeg
			x11-libs/gtk+:2
		)
	)"

S=${WORKDIR}/data

pkg_nofetch() {
	einfo "Please buy & download ${SRC_URI} from:"
	einfo "  ${HOMEPAGE}"
	einfo "and move it to ${DISTDIR}"
	einfo
}

src_unpack() {
	unpack_zip ${A}
}

src_prepare() {
	if ! use bundled-libs ; then
		einfo "Removing bundled libs..."
		use x86 && { rm -v all/hge_lib/liballegro* || die ; }
		rm -v all/hge_lib/libjpeg.so* all/hge_lib/libpng12.so*
	fi
}

src_install() {
	insinto "${MYGAMEDIR}"
	doins -r all/*

	dodoc Linux.README

	newicon SmileLogo.png ${PN}.png
	make_desktop_entry ${PN}
	games_make_wrapper ${PN} "./BeatHazard_Linux2" "${MYGAMEDIR}" "${MYGAMEDIR}/hge_lib"

	fperms +x "${MYGAMEDIR}"/BeatHazard_Linux2
	prepgamesdirs
}
