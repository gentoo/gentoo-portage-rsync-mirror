# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake4-bin/quake4-bin-1.3.2.ebuild,v 1.11 2012/02/08 21:20:12 vapier Exp $

inherit eutils unpacker versionator games

MY_PV=$(replace_version_separator 2 '-')

DESCRIPTION="Sequel to Quake 2, an id Software 3D first-person shooter"
HOMEPAGE="http://www.quake4game.com/"
SRC_URI="mirror://idsoftware/quake4/linux/quake4-linux-${MY_PV}.x86.run"

LICENSE="QUAKE4"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE="alsa cdinstall dedicated opengl"
RESTRICT="strip"

UIDEPEND="virtual/opengl
	x86? (
		x11-libs/libXext
		x11-libs/libX11
		x11-libs/libXau
		x11-libs/libXdmcp
		media-libs/libsdl
	)
	amd64? (
		app-emulation/emul-linux-x86-sdl
		app-emulation/emul-linux-x86-xlibs
		|| (
			>=app-emulation/emul-linux-x86-xlibs-7.0
			x11-drivers/nvidia-drivers
			>=x11-drivers/ati-drivers-8.8.25-r1
		)
	)
	alsa? ( >=media-libs/alsa-lib-1.0.6 )"
RDEPEND="sys-libs/glibc
	dedicated? ( app-misc/screen )
	amd64? ( app-emulation/emul-linux-x86-baselibs )
	opengl? ( ${UIDEPEND} )
	cdinstall? ( games-fps/quake4-data )
	!dedicated? ( !opengl? ( ${UIDEPEND} ) )"

S=${WORKDIR}

dir=${GAMES_PREFIX_OPT}/quake4
Ddir=${D}/${dir}

QA_TEXTRELS="${dir}/libSDL-1.2.id.so.0
	${dir}/pb/pbags.so
	${dir}/pb/pbcl.so
	${dir}/pb/pbag.so
	${dir}/pb/pbsv.so
	${dir}/pb/pbcls.so"
QA_EXECSTACK="${dir}/quake4.x86
	${dir}/libSDL-1.2.id.so.0
	${dir}/q4ded.x86
	${dir}/libgcc_s.so.1
	${dir}/quake4smp.x86
	${dir}/libstdc++.so.6"

src_install() {
	insinto "${dir}"
	exeinto "${dir}"

	doins *.txt README q4icon.bmp us/version.info README-1.3.htm || die "docs"
	doins -r pb || die "pb"
	doexe openurl.sh || die "openurl.sh"
	doexe bin/Linux/x86/quake4.x86 bin/Linux/x86/q4ded.x86 \
		bin/Linux/x86/libgcc_s.so.1 bin/Linux/x86/libstdc++.so.* \
		bin/Linux/x86/libSDL-1.2.id.so.0 bin/Linux/x86/quake4smp.x86 \
		|| die "doexe x86 exes/libs"

	insinto "${dir}"/q4base
	doins q4base/* us/q4base/* || die "doins q4base"
	if use dedicated
	then
		games_make_wrapper quake4-ded ./q4ded.x86 "${dir}" "${dir}"
	fi

	if use opengl || ! use dedicated
	then
		games_make_wrapper quake4 ./quake4.x86 "${dir}" "${dir}"
		games_make_wrapper quake4-smp ./quake4smp.x86 "${dir}" "${dir}"
#		doicon ${FILESDIR}/quake4.png || die "copying icon"
#		make_desktop_entry quake4 "Quake IV" quake4
#		make_desktop_entry quake4-smp "Quake IV (SMP)" quake4
		newicon q4icon.bmp quake4.bmp || die "copying icon"
		make_desktop_entry quake4 "Quake IV" /usr/share/pixmaps/quake4.bmp
		make_desktop_entry quake4-smp "Quake IV (SMP)" /usr/share/pixmaps/quake4.bmp
	fi

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	if ! use cdinstall
	then
		elog "You need to copy pak001.pk4 through pak012.pk4, along with"
		elog "zpak*.pk4 from either your installation media or your hard drive"
		elog "to ${dir}/q4base before running the game."
		echo
	fi
	if use opengl || ! use dedicated
	then
		elog "To play the game run:"
		elog " quake4"
		echo
	fi
}
