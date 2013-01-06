# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/etqw-bin/etqw-bin-1.5.ebuild,v 1.5 2011/02/13 17:45:56 nyhm Exp $

inherit eutils games

DESCRIPTION="Enemy Territory: Quake Wars"
HOMEPAGE="http://zerowing.idsoftware.com/linux/etqw/"
SRC_URI="ftp://ftp.i3d.net/Games/Enemy%20Territory%20Quake%20Wars/Patches/ETQW-client-${PV}-full.x86.run"

LICENSE="ETQW"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE="cdinstall"
RESTRICT="strip"

DEPEND="app-arch/unzip"
RDEPEND="sys-libs/glibc
	virtual/opengl
	amd64? ( app-emulation/emul-linux-x86-sdl )
	x86? (
		media-libs/libsdl
		media-libs/alsa-lib
	)
	cdinstall? ( games-fps/etqw-data )"

S=${WORKDIR}/data
dir=${GAMES_PREFIX_OPT}/etqw

QA_TEXTRELS="${dir:1}/pb/*.so"
QA_EXECSTACK="${dir:1}/*.x86
	${dir:1}/*.so*"

src_unpack() {
	tail -c +194885 "${DISTDIR}"/${A} > ${A}.zip
	unpack ./${A}.zip
	rm -f ${A}.zip
}

src_install() {
	insinto "${dir}"
	doins -r base pb *.png *.txt || die "doins failed"

	exeinto "${dir}"
	doexe etqw{,-rthread}.x86 openurl.sh *.so* || die "doexe failed"

	newicon etqw_icon.png etqw.png
	games_make_wrapper etqw ./etqw.x86 "${dir}" "${dir}"
	make_desktop_entry etqw "Enemy Territory: Quake Wars" etqw

	games_make_wrapper etqw-rthread ./etqw-rthread.x86 "${dir}" "${dir}"
	make_desktop_entry etqw-rthread "Enemy Territory: Quake Wars (SMP)" etqw

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	if ! use cdinstall ; then
		elog "You need to copy pak00*.pk4, zpak_*.pk4 and the megatextures"
		elog "directory to ${dir}/base before running the game."
	fi
	elog "To change the game language from English, add"
	elog "seta sys_lang \"your_language\" to your autoexec.cfg file."
	elog "Menu fonts may not show up until you do so."
}
