# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake4-demo/quake4-demo-1.0.ebuild,v 1.17 2012/02/08 23:18:01 vapier Exp $

inherit eutils unpacker games

MY_P="quake4-linux-${PV}-demo"
DESCRIPTION="Sequel to Quake 2, an Id 3D first-person shooter"
HOMEPAGE="http://www.quake4game.com/"
SRC_URI="mirror://idsoftware/quake4/demo/${MY_P}.x86.run
	http://www.3ddownloads.com/Action/Quake%204/Demos/${MY_P}.x86.run
	mirror://3dgamers/quake4/${MY_P}.x86.run
	http://filebase.gmpf.de/quake4/${MY_P}.x86.run
	http://www.holarse.de/mirror/${MY_P}.x86.run
	http://sonic-lux.net/data/mirror/quake4/${MY_P}.x86.run"

LICENSE="QUAKE4"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE="alsa opengl dedicated"
RESTRICT="strip"
QA_EXECSTACK_x86="${GAMES_PREFIX_OPT:1}/${PN}/*"

UIDEPEND="virtual/opengl
	x86? (
		x11-libs/libXext
		x11-libs/libX11
		x11-libs/libXau
		x11-libs/libXdmcp
		media-libs/libsdl )
	amd64? (
		app-emulation/emul-linux-x86-sdl
		app-emulation/emul-linux-x86-xlibs
		|| (
			>=app-emulation/emul-linux-x86-xlibs-7.0
			x11-drivers/nvidia-drivers
			>=x11-drivers/ati-drivers-8.8.25-r1 ) )
	alsa? ( >=media-libs/alsa-lib-1.0.6 )"

RDEPEND="sys-libs/glibc
	dedicated? ( app-misc/screen )
	amd64? ( app-emulation/emul-linux-x86-baselibs )
	opengl? ( ${UIDEPEND} )
	!dedicated? ( !opengl? ( ${UIDEPEND} ) )"

S=${WORKDIR}

dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

src_install() {
	insinto "${dir}"
	doins License.txt README q4icon.bmp version.info # CHANGES
	exeinto "${dir}"
	doexe openurl.sh || die "openurl.sh"
	if use x86; then
		doexe bin/Linux/x86/quake4.x86 bin/Linux/x86/q4ded.x86 \
			bin/Linux/x86/libgcc_s.so.1 bin/Linux/x86/libstdc++.so.5 \
			|| die "doexe x86 exes/libs"
	elif use amd64; then
		doexe bin/Linux/x86_64/quake4.x86 bin/Linux/x86_64/q4ded.x86 \
			bin/Linux/x86_64/libgcc_s.so.1 bin/Linux/x86_64/libstdc++.so.5 \
			|| die "doexe amd64 exes/libs"
	else
		die "Cannot copy executables!"
	fi

#	insinto "${dir}"/pb
#	doins pb/* || die "doins pb"
	insinto "${dir}"/q4base
	if use dedicated
	then
		doins q4base/* || die "doins q4base"
		games_make_wrapper quake4-ded ./q4ded.x86 "${dir}" "${dir}"
	else
		doins q4base/*.pk4 || die "doins q4base"
	fi
#	doins us/q4base/* || die "installing us/q4base/*"

	if use opengl
	then
		games_make_wrapper ${PN} ./quake4.x86 "${dir}" "${dir}"
		newicon q4icon.bmp ${PN}.bmp || die "copying icon"
		make_desktop_entry ${PN} "Quake IV (Demo)" /usr/share/applications/${PN}.bmp
	fi

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	elog "To play the game run:"
	elog " quake4-demo"
	echo
}
