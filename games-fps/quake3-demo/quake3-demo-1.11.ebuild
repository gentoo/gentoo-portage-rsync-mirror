# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-demo/quake3-demo-1.11.ebuild,v 1.29 2012/12/25 19:07:03 tupone Exp $

inherit eutils unpacker games

DESCRIPTION="the playable demo of Quake III Arena by Id Software"
HOMEPAGE="http://www.idsoftware.com/games/quake/quake3-arena/"
SRC_URI="mirror://idsoftware/quake3/linux/linuxq3ademo-${PV}-6.x86.gz.sh
	mirror://3dgamers/quake3arena/linuxq3ademo-${PV}-6.x86.gz.sh"

LICENSE="Q3AEULA"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE="opengl dedicated 3dfx"
RESTRICT="strip"

UIDEPEND="virtual/opengl
	x86? (
		x11-libs/libXext
		x11-libs/libX11
		x11-libs/libXau
		x11-libs/libXdmcp )
	amd64? (
		app-emulation/emul-linux-x86-xlibs
		|| (
			>=app-emulation/emul-linux-x86-xlibs-7.0
			x11-drivers/nvidia-drivers
			>=x11-drivers/ati-drivers-8.8.25-r1 ) )"

RDEPEND="sys-libs/glibc
	dedicated? ( app-misc/screen )
	amd64? ( app-emulation/emul-linux-x86-baselibs )
	opengl? ( ${UIDEPEND} )
	!dedicated? ( !opengl? ( ${UIDEPEND} ) )"

S=${WORKDIR}

dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}
QA_PREBUILT="${dir:1}/q3ded.x86
	${dir:1}/q3demo.x86"

src_unpack() {
	unpack_makeself
}

src_install() {
	insinto "${dir}"
	doins -r Help demoq3
	doins README icon.*

	exeinto "${dir}"
	newexe bin/x86/glibc-2.0/q3ded q3ded.x86
	newexe bin/x86/glibc-2.0/q3demo q3demo.x86
	use 3dfx && doexe bin/x86/glibc-2.0/libMesaVoodooGL.so*

	games_make_wrapper q3demo ./q3demo.x86 "${dir}" "${dir}"

	make_desktop_entry q3demo "Quake III (Demo)"

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "To play the game run:"
	elog " q3demo"
}
