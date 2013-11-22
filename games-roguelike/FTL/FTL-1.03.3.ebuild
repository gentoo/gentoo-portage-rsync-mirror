# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/FTL/FTL-1.03.3.ebuild,v 1.4 2013/11/22 15:19:10 hasufell Exp $

EAPI=5

inherit eutils games

DESCRIPTION="Faster Than Light: A spaceship simulation real-time roguelike-like game"
HOMEPAGE="http://www.ftlgame.com/"
SRC_URI="FTL.Linux.${PV}.tar.gz"

LICENSE="all-rights-reserved Boost-1.0 free-noncomm MIT bundled-libs? ( FTL LGPL-2.1 ZLIB libpng )"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE="bundled-libs"
RESTRICT="fetch bindist splitdebug"

RDEPEND="
	sys-devel/gcc[cxx]
	virtual/opengl
	!bundled-libs? (
		media-libs/devil[png,opengl]
		media-libs/freetype:2
		media-libs/libsdl[X,audio,joystick,opengl,video]
		sys-libs/zlib
	)"

QA_PREBUILT="${GAMES_PREFIX_OPT#/}/${PN}/bin/${PN}
	${GAMES_PREFIX_OPT#/}/${PN}/lib/*"

S=${WORKDIR}/${PN}

pkg_nofetch() {
	einfo "Please buy & download ${SRC_URI} from:"
	einfo "  ${HOMEPAGE}"
	einfo "and move it to ${DISTDIR}"
	einfo
}

src_prepare() {
	if ! use bundled-libs ; then
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
