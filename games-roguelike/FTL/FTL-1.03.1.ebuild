# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/FTL/FTL-1.03.1.ebuild,v 1.6 2013/04/11 16:50:27 hasufell Exp $

# TODO: update libpng to slot 1.5 when stable

EAPI=5

inherit eutils games

DESCRIPTION="Faster Than Light: A spaceship simulation real-time roguelike-like game"
HOMEPAGE="http://www.ftlgame.com/"
SRC_URI="ftl_faster_than_light-linux-${PV}.tar.gz"

LICENSE="all-rights-reserved Boost-1.0 free-noncomm MIT !system-libs? ( FTL LGPL-2.1 ZLIB libpng )"
SLOT="0"
KEYWORDS="-* ~amd64 x86"
IUSE="+system-libs"
RESTRICT="fetch bindist"

RDEPEND="
	=media-libs/libpng-1.5*
	sys-devel/gcc[cxx]
	virtual/opengl
	system-libs? (
		media-libs/devil[png,opengl]
		media-libs/freetype:2
		media-libs/libsdl[X,audio,joystick,opengl,video]
		sys-libs/zlib
	)"

QA_PREBUILT="${GAMES_PREFIX_OPT}/${PN}/bin/${PN}
	${GAMES_PREFIX_OPT}/${PN}/lib/*"

S=${WORKDIR}/${PN}

pkg_nofetch() {
	einfo "Please buy & download ${SRC_URI} from:"
	einfo "  ${HOMEPAGE}"
	einfo "and move it to ${DISTDIR}"
	einfo
}

src_prepare() {
	if use system-libs ; then
		# no system lib for libbass available
		find data/${ARCH}/lib -type f \! -name "libbass*" -delete || die
	fi
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}

	insinto "${dir}"
	doins -r data/resources
	doins data/exe_icon.bmp

	exeinto "${dir}"/bin
	doexe data/${ARCH}/bin/${PN}
	exeinto "${dir}"/lib
	doexe data/${ARCH}/lib/*.so*

	games_make_wrapper ${PN} "${dir}/bin/${PN}" "${dir}" "${dir}/lib"
	make_desktop_entry ${PN} "Faster Than Light" "/usr/share/pixmaps/FTL.bmp"

	newicon data/exe_icon.bmp FTL.bmp
	dohtml ${PN}_README.html

	prepgamesdirs
}
