# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/crayon-physics/crayon-physics-55.ebuild,v 1.1 2013/03/21 22:03:58 hasufell Exp $

EAPI=5

inherit eutils gnome2-utils games

DESCRIPTION="2D physics puzzle/sandbox game with drawing"
HOMEPAGE="http://www.crayonphysics.com/"
SRC_URI="crayon_physics_deluxe-linux-release${PV}.tar.gz"

LICENSE="CRAYON-PHYSICS"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="bundled-libs"
RESTRICT="bindist fetch"

MYGAMEDIR=${GAMES_PREFIX_OPT}/${PN}
QA_PREBUILT="${MYGAMEDIR#/}/crayon
	${MYGAMEDIR#/}/lib32/*"

# fuck this pulseaudio linkage
RDEPEND="
	virtual/opengl
	amd64? (
		app-emulation/emul-linux-x86-opengl
		app-emulation/emul-linux-x86-qtlibs
		app-emulation/emul-linux-x86-sdl
		app-emulation/emul-linux-x86-soundlibs
		app-emulation/emul-linux-x86-xlibs
	)
	x86? (
		media-sound/pulseaudio
		dev-qt/qtcore:4
		dev-qt/qtgui:4
		virtual/glu
		x11-libs/libX11
		!bundled-libs? (
			media-libs/libmikmod
			media-libs/libsdl[X,audio,video,opengl,joystick]
			media-libs/libvorbis
			media-libs/sdl-image[png,jpeg,tiff]
			media-libs/sdl-mixer[vorbis,wav]
			media-libs/smpeg[X,opengl]
			media-libs/tiff:0
			virtual/jpeg
		)
	)"

S=${WORKDIR}/CrayonPhysicsDeluxe

pkg_nofetch() {
	einfo "Please buy & download ${SRC_URI} from:"
	einfo "  ${HOMEPAGE}"
	einfo "and move it to ${DISTDIR}"
	einfo
}

src_prepare() {
	if use bundled-libs ; then
		mv lib32/_libSDL-1.2.so.0 lib32/libSDL-1.2.so.0 || die
	fi
}

src_install() {
	insinto "${MYGAMEDIR}"
	use bundled-libs && doins -r lib32
	doins -r cache data crayon autoexec.txt version.xml

	newicon -s 256 icon.png ${PN}.png
	make_desktop_entry ${PN}
	games_make_wrapper ${PN} "./crayon" "${MYGAMEDIR}" "${MYGAMEDIR}/lib32"

	dodoc changelog.txt linux_hotfix_notes.txt
	dohtml readme.html

	fperms +x "${MYGAMEDIR}"/crayon
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
