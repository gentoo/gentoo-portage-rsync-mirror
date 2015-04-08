# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/crayon-physics/crayon-physics-55.ebuild,v 1.9 2015/03/28 22:14:06 mgorny Exp $

EAPI=5

inherit eutils gnome2-utils games

DESCRIPTION="2D physics puzzle/sandbox game with drawing"
HOMEPAGE="http://www.crayonphysics.com/"
SRC_URI="crayon_physics_deluxe-linux-release${PV}.tar.gz"

LICENSE="CRAYON-PHYSICS"
SLOT="0"
KEYWORDS="-* ~amd64 x86"
IUSE="bundled-libs"
RESTRICT="bindist fetch splitdebug"

MYGAMEDIR=${GAMES_PREFIX_OPT}/${PN}
QA_PREBUILT="${MYGAMEDIR#/}/crayon
	${MYGAMEDIR#/}/lib32/*"

# fuck this pulseaudio linkage
RDEPEND="
	|| (
		(
			media-sound/pulseaudio[abi_x86_32(-)]
			dev-qt/qtcore:4[abi_x86_32(-)]
			dev-qt/qtgui:4[abi_x86_32(-)]
			virtual/glu[abi_x86_32(-)]
			virtual/opengl[abi_x86_32(-)]
			x11-libs/libX11[abi_x86_32(-)]
		)
		amd64? (
			app-emulation/emul-linux-x86-opengl[-abi_x86_32(-)]
			app-emulation/emul-linux-x86-qtlibs[-abi_x86_32(-)]
			app-emulation/emul-linux-x86-sdl[-abi_x86_32(-)]
			app-emulation/emul-linux-x86-soundlibs[-abi_x86_32(-)]
			app-emulation/emul-linux-x86-xlibs[-abi_x86_32(-)]
		)
	)
	x86? (
		!bundled-libs? (
			media-libs/libmikmod
			media-libs/libsdl:0[X,sound,video,opengl,joystick]
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
