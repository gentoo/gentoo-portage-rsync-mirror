# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/doom3/doom3-1.3.1304.ebuild,v 1.6 2012/02/05 06:02:13 vapier Exp $

inherit eutils unpacker games

MY_PV="1.3.1.1304"

DESCRIPTION="3rd installment of the classic iD 3D first-person shooter"
HOMEPAGE="http://www.doom3.com/"
SRC_URI="mirror://idsoftware/doom3/linux/doom3-linux-${MY_PV}.x86.run
	http://zerowing.idsoftware.com/linux/${PN}.png"

LICENSE="DOOM3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="alsa cdinstall dedicated opengl roe"
RESTRICT="strip"

DEPEND="app-arch/bzip2
	app-arch/tar"
RDEPEND="sys-libs/glibc
	opengl? ( virtual/opengl )
	alsa? ( >=media-libs/alsa-lib-1.0.6 )
	cdinstall? (
		>=games-fps/doom3-data-1.1.1282-r1
		roe? ( games-fps/doom3-roe ) )
	amd64? (
		app-emulation/emul-linux-x86-xlibs
		app-emulation/emul-linux-x86-soundlibs
		|| (
			>=app-emulation/emul-linux-x86-xlibs-7.0
			x11-drivers/nvidia-drivers
			>=x11-drivers/ati-drivers-8.8.25-r1 ) )"

S=${WORKDIR}
dir=${GAMES_PREFIX_OPT}/${PN}

QA_TEXTRELS="${dir:1}/pb/pbcl.so
	${dir:1}/pb/pbcls.so
	${dir:1}/pb/pbag.so
	${dir:1}/pb/pbsv.so
	${dir:1}/pb/pbags.so"

QA_EXECSTACK="${dir:1}/libgcc_s.so.1
	${dir:1}/libstdc++.so.6
	${dir:1}/doom.x86
	${dir:1}/doomded.x86"

src_unpack() {
	unpack_makeself ${PN}-linux-${MY_PV}.x86.run
}

src_install() {
	insinto "${dir}"
	doins License.txt CHANGES README version.info ${PN}.png || die

	exeinto "${dir}"
	doexe *.so.? || die "doexe libs"
	doexe openurl.sh || die "openurl.sh"

	if use amd64 ; then
		doexe bin/Linux/amd64/doom{,ded}.x86 || die "doexe amd64"
	else
		doexe bin/Linux/x86/doom{,ded}.x86 || die "doexe x86"
	fi

	doins -r base d3xp pb || die "doins base d3xp pb"

	games_make_wrapper ${PN} ./doom.x86 "${dir}" "${dir}"
	if use dedicated ; then
		games_make_wrapper ${PN}-ded ./doomded.x86 "${dir}" "${dir}"
	fi

	doicon "${DISTDIR}"/${PN}.png || die "doicon"
	make_desktop_entry ${PN} "Doom III"

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	if ! use cdinstall; then
		elog "You need to copy pak000.pk4, pak001.pk4, pak002.pk4, pak003.pk4, and"
		elog "pak004.pk4 from either your installation media or your hard drive to"
		elog "${dir}/base before running the game,"
		elog "or 'emerge games-fps/doom3-data' to install from CD."
		echo
		if use roe ; then
			elog "To use the Resurrection of Evil expansion pack, you also need to copy"
			elog "pak000.pk4 to ${dir}/d3xp from the RoE CD before running the game,"
			elog "or 'emerge doom3-roe' to install from CD."
		fi
	fi

	echo
	elog "To play the game, run:"
	elog " doom3"
	echo
}
