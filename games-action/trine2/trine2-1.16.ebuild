# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/trine2/trine2-1.16.ebuild,v 1.6 2013/05/09 14:15:54 hasufell Exp $

EAPI=5
inherit eutils unpacker gnome2-utils games

MY_PN="Trine 2"
DESCRIPTION="A sidescrolling game of action, puzzles and platforming"
HOMEPAGE="http://www.trine2.com/"
SRC_URI="${PN}_linux_installer.run"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="bundled-libs +launcher"
RESTRICT="fetch bindist splitdebug"

QA_PREBUILT="${GAMES_PREFIX_OPT}/${PN}/${PN}*
	${GAMES_PREFIX_OPT}/${PN}/lib/*"

# TODO: bundled-libs: no libsdl-1.3, no physx
RDEPEND="
	amd64? (
		app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-opengl
		app-emulation/emul-linux-x86-sdl
		app-emulation/emul-linux-x86-soundlibs
		app-emulation/emul-linux-x86-xlibs
		launcher? ( app-emulation/emul-linux-x86-gtklibs )
		!bundled-libs? ( media-gfx/nvidia-cg-toolkit[multilib] )
	)
	x86? (
		dev-libs/glib:2
		media-libs/freetype
		media-libs/libogg
		media-libs/libvorbis
		media-libs/openal
		sys-libs/zlib
		virtual/glu
		virtual/opengl
		launcher? (
			media-libs/fontconfig
			media-libs/libpng:1.5
			x11-libs/gtk+:2
			x11-libs/libSM
			x11-libs/libX11
			x11-libs/libXinerama
			x11-libs/libXxf86vm
		)
		!bundled-libs? ( media-gfx/nvidia-cg-toolkit )
	)"

S=${WORKDIR}

pkg_nofetch() {
	einfo
	einfo "Please buy & download \"${SRC_URI}\" from:"
	einfo "  ${HOMEPAGE}"
	einfo "and move/link it to \"${DISTDIR}\""
	einfo
}

src_unpack() {
	local offset="$(( $(grep -a -h -n -m 1 -F -e THIS_IS_THE_LAST_SCRIPT_LINE_ARCHIVE_DATA_FOLLOWS "${DISTDIR}"/${A} | cut -d':' -f1) + 1 ))"
	unpack_makeself ${A} "${offset}" "tail"
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}

	insinto "${dir}"
	doins -r data*

	exeinto "${dir}"
	newexe "bin/trine2_linux_32bit" ${PN}

	exeinto "${dir}/lib"
	use bundled-libs || { find lib/lib32 -type f -name "libCg*.so*" -delete || die ;}
	doexe lib/lib32/*

	games_make_wrapper ${PN} "./${PN}" "${dir}" "${dir}/lib"
	doicon -s 64 ${PN}.png
	make_desktop_entry ${PN} "${MY_PN}"

	if use launcher ; then
		exeinto "${dir}"
		newexe bin/trine2_linux_launcher_32bit ${PN}-launcher

		games_make_wrapper ${PN}-launcher "./${PN}-launcher" "${dir}" "${dir}/lib"
		make_desktop_entry ${PN}-launcher "${MY_PN} (launcher)"

		# launcher binary has hardcoded the script path
		dodir "${dir}"/bin
		dosym "${GAMES_BINDIR}"/trine2 "${dir}"/bin/trine2_bin_starter.sh
	fi

	dodoc KNOWN_LINUX_ISSUES README

	prepgamesdirs
}

pkg_preinst() {
	games_pkg_preinst
	gnome2_icon_savelist
}

pkg_postinst() {
	games_pkg_postinst

	einfo
	elog "${MY_PN} savegames and configurations are stored in:"
	elog "   \${HOME}/.frozenbyte/${MY_PN//\ /}"
	einfo

	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
