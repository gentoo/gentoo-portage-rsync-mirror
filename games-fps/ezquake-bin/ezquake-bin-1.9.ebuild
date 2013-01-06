# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ezquake-bin/ezquake-bin-1.9.ebuild,v 1.1 2008/06/04 19:43:14 mr_bones_ Exp $

inherit games

MY_PN="${PN/-bin/}"
SECURITY_PV=1.8.2
DESCRIPTION="Quakeworld client with mqwcl functionality and many more features."
HOMEPAGE="http://ezquake.sf.net/"
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_PN}_linux-x86_${PV}.tar.gz
	security? ( http://uttergrottan.localghost.net/${MY_PN}/security/${MY_PN}_security_${SECURITY_PV}.zip )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
RESTRICT="strip"
IUSE="cdinstall opengl security svga"

QA_EXECSTACK_x86="${GAMES_PREFIX_OPT:1}/ezquake-bin/ezquake-gl.glx
	${GAMES_PREFIX_OPT:1}/ezquake-bin/ezquake.x11
	${GAMES_PREFIX_OPT:1}/ezquake-bin/ezquake.svga"
QA_EXECSTACK_amd64="${GAMES_PREFIX_OPT:1}/ezquake-bin/ezquake-gl.glx
	${GAMES_PREFIX_OPT:1}/ezquake-bin/ezquake.x11
	${GAMES_PREFIX_OPT:1}/ezquake-bin/ezquake.svga"

RDEPEND=">=dev-libs/expat-2.0
	sys-libs/glibc
	!svga? ( x11-libs/libXext )
	svga? ( media-libs/svgalib )
	opengl? ( virtual/opengl x11-libs/libXext )
	cdinstall? ( games-fps/quake1-data )"
DEPEND="${RDEPEND}
	security? ( app-arch/zip )"
dir=${GAMES_PREFIX_OPT}/${PN}

src_install() {
	exeinto "${dir}"
	insinto "${dir}"

	local x BINS="ezquake.x11"
	use svga && BINS="${BINS} ezquake.svga"
	use opengl && BINS="${BINS} ezquake-gl.glx"

	doexe ${BINS} || die "doexe"
	if use security ; then
		doexe "${MY_PN}-security.so" || die "doexe"
	fi
	doins -r ezquake qw || die "doins failed"

	dosym "${GAMES_DATADIR}"/quake1/id1 "${dir}"/id1

	for x in ${BINS}; do
		games_make_wrapper ${x} ./${x} "${dir}" "${dir}"
	done

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	if use !cdinstall; then
		elog "NOTE that this client doesn't include .pak files. You *should*"
		elog "enable \"cdinstall\" flag or install quake1-demodata."
		elog "You can also copy the files from your Quake1 CD to"
		elog "  ${dir}/quake1/id1 (all names lowercase)"
		elog ""
		elog "You may also want to check:"
		elog " http://fuhquake.quakeworld.nu - complete howto on commands and variables"
		elog " http://equake.quakeworld.nu - free package containing various files"
	fi
}
