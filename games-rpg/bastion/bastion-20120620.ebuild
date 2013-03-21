# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/bastion/bastion-20120620.ebuild,v 1.1 2013/03/21 22:17:15 hasufell Exp $

# TODO: - unbundle mono when multilib
#       - unbundle fmodex when multilib

EAPI=5

inherit eutils gnome2-utils check-reqs unpacker games

TIMESTAMP=${PV:0:4}-${PV:4:2}-${PV:6:2}
DESCRIPTION="An original action role-playing game set in a lush imaginative world"
HOMEPAGE="http://supergiantgames.com/?page_id=242"
SRC_URI="Bastion-HIB-${TIMESTAMP}.sh"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="bundled-libs"
RESTRICT="bindist fetch"

MYGAMEDIR=${GAMES_PREFIX_OPT}/${PN}
QA_PREBUILT="${MYGAMEDIR#/}/Bastion.bin.x86
	${MYGAMEDIR#/}/lib/*"

# mono shit: vague dependencies
RDEPEND="
	virtual/opengl
	amd64? (
		app-emulation/emul-linux-x86-sdl
		app-emulation/emul-linux-x86-soundlibs
		app-emulation/emul-linux-x86-xlibs
	)
	x86? (
		media-libs/freealut
		media-libs/openal
		media-libs/sdl-gfx
		media-libs/sdl-image
		media-libs/sdl-mixer
		media-libs/sdl-net
		media-libs/sdl-ttf
		media-libs/smpeg
		x11-libs/libX11
		x11-libs/libXft
		!bundled-libs? (
			dev-lang/mono
			media-libs/fmod:1
			media-libs/libsdl[X,audio,video,opengl,joystick]
		)
	)"

CHECKREQS_DISK_BUILD="2400M"

pkg_pretend() {
	if has splitdebug ${FEATURES}; then
		eerror "FEATURES=splitdebug is broken for this package, disable it locally"
		die "FEATURES=splitdebug is broken for this package, disable it locally"
	fi

	check-reqs_pkg_pretend
}

pkg_nofetch() {
	einfo "Please buy & download ${SRC_URI} from:"
	einfo "  ${HOMEPAGE}"
	einfo "and move it to ${DISTDIR}"
}

src_unpack() {
	local myarch=$(usex amd64 "x86" "x86_64")

	unpack_makeself

	mv instarchive_all{,.tar.lzma} || die
	mv instarchive_linux_${myarch}{,.tar.lzma} || die

	mkdir ${P} || die
	cd ${P} || die

	unpack ./../instarchive_{all,linux_${myarch}}.tar.lzma
}

src_prepare() {
	if ! use bundled-libs ; then
		einfo "Removing bundles libs..."
		rm -v lib/libSDL-1.2.so* || die
		use x86 && { rm -v lib/libmono-2.0.so* lib/libfmodex.so* || die ;}
	fi
}

src_install() {
	insinto "${MYGAMEDIR}"
	doins -r *

	newicon -s 256 Bastion.png ${PN}.png
	make_desktop_entry ${PN}
	games_make_wrapper ${PN} "./Bastion.bin.x86" "${MYGAMEDIR}" "${MYGAMEDIR}/lib"

	fperms +x "${MYGAMEDIR}"/Bastion.bin.x86
	prepgamesdirs
}

pkg_preinst() {
	games_pkg_preinst
	gnome2_icon_savelist
}

pkg_postinst() {
	games_pkg_postinst

	elog "If you are using opensource drivers you should consider installing:"
	elog "    media-libs/libtxc_dxtn"

	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
