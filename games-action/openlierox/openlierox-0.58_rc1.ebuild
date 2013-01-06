# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/openlierox/openlierox-0.58_rc1.ebuild,v 1.4 2012/03/03 01:28:03 sping Exp $

EAPI="2"

inherit cmake-utils eutils games

MY_PN="OpenLieroX"
MY_P="${MY_PN}_${PV}"
DESCRIPTION="Real-time excessive Worms-clone"
HOMEPAGE="http://openlierox.sourceforge.net/"
SRC_URI="mirror://sourceforge/openlierox/${MY_P}.src.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X breakpad debug joystick"

RDEPEND="media-libs/sdl-mixer
	media-libs/sdl-image
	media-libs/gd[jpeg,png]
	dev-libs/libxml2
	dev-libs/libzip
	net-misc/curl
	joystick? ( media-libs/libsdl[joystick] )
	!joystick? ( media-libs/libsdl )
	X? ( x11-libs/libX11
		media-libs/libsdl[X] )
	!X? ( media-libs/libsdl )"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_PN}"

src_configure() {
	local mycmakeargs="
		$(cmake-utils_use debug DEBUG)
		$(cmake-utils_use X X11)
		-D BREAKPAD=$(use breakpad && echo "Yes" || echo "No")
		-D DISABLE_JOYSTICK=$(use joystick && echo "No" || echo "Yes")
		-D SYSTEM_DATA_DIR=${GAMES_DATADIR}
		-D VERSION=${PV}"

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	# NOTE: App uses case-insensitive file-handling
	insinto "${GAMES_DATADIR}"/${PN}/
	doins -r share/gamedir/* || die "doins failed"

	dodoc doc/{README,ChangeLog,Development,TODO} || die "dodoc failed"
	insinto /usr/share/doc/"${PF}"
	doins -r doc/original_lx_docs || die "doins failed"

	doicon share/OpenLieroX.* || die "doicon failed"
	make_desktop_entry openlierox OpenLieroX OpenLieroX \
			"Game;ActionGame;ArcadeGame;" || die "make_desktop_entry failed"

	dogamesbin "${CMAKE_BUILD_DIR}"/bin/openlierox || die "dogamesbin failed"

	prepgamesdirs
}
