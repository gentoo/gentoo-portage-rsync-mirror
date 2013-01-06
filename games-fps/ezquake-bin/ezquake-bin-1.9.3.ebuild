# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ezquake-bin/ezquake-bin-1.9.3.ebuild,v 1.4 2009/12/02 21:54:40 mr_bones_ Exp $

EAPI=2
inherit games

MY_PN="${PN/-bin/}"
DESCRIPTION="Quakeworld client with mqwcl functionality and many more features."
HOMEPAGE="http://ezquake.sf.net/"
SRC_URI="amd64? ( mirror://sourceforge/${MY_PN}/${MY_PN}_linux-x86_64.${PV}.tar.gz )
	x86? ( mirror://sourceforge/${MY_PN}/${MY_PN}_linux-x86_${PV}.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="strip"
IUSE="cdinstall opengl svga +X"

QA_EXECSTACK_x86="${GAMES_PREFIX_OPT:1}/ezquake-bin/ezquake-gl.glx
	${GAMES_PREFIX_OPT:1}/ezquake-bin/ezquake.x11
	${GAMES_PREFIX_OPT:1}/ezquake-bin/ezquake.svga"
QA_EXECSTACK_amd64="${GAMES_PREFIX_OPT:1}/ezquake-bin/ezquake-gl.glx
	${GAMES_PREFIX_OPT:1}/ezquake-bin/ezquake.x11
	${GAMES_PREFIX_OPT:1}/ezquake-bin/ezquake.svga"

DEPEND="cdinstall? ( games-fps/quake1-data )"
RDEPEND="${DEPEND}
	X? ( x11-libs/libXext )
	svga? ( media-libs/svgalib )
	opengl? (
		virtual/opengl
		x11-libs/libXxf86dga
		x11-libs/libXxf86vm
	)"

S=${WORKDIR}/${MY_PN}

dir=${GAMES_PREFIX_OPT}/${PN}

src_unpack() {
	unpack ${A}
	if use amd64; then
		mv ${MY_PN}_linux-x86_64.${PV} "${MY_PN}"
	else
		mv ${MY_PN}_linux-x86.${PV} "${MY_PN}"
	fi
}

src_install() {
	exeinto "${dir}"
	insinto "${dir}"

	local x BINS=""
	use X && BINS="ezquake.x11"
	use svga && BINS="${BINS} ezquake.svga"
	use opengl && BINS="${BINS} ezquake-gl.glx"

	doexe ${BINS} || die "doexe"
	doins -r ezquake qw || die "doins failed"
	dosym "${GAMES_DATADIR}"/quake1/id1 "${dir}"/id1

	for x in ${BINS}; do
		games_make_wrapper ${x} ./${x} "${dir}" "${dir}"
	done

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	if ! use cdinstall; then
		elog "NOTE that this client doesn't include .pak files. You *should*"
		elog "enable \"cdinstall\" flag or install quake1-demodata with the symlink use flag."
		elog "You can also copy the files from your Quake1 CD to"
		elog "  ${dir}/quake1/id1 (all names lowercase)"
		elog ""
		elog "You may also want to check:"
		elog " http://fuhquake.quakeworld.nu - complete howto on commands and variables"
		elog " http://equake.quakeworld.nu - free package containing various files"
	fi
}
