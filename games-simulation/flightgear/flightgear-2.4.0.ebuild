# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/flightgear/flightgear-2.4.0.ebuild,v 1.5 2012/08/21 07:08:05 xmw Exp $

EAPI=3

inherit autotools eutils games

DESCRIPTION="Open Source Flight Simulator"
HOMEPAGE="http://www.flightgear.org/"
SRC_URI="mirror://flightgear/Source/${P}.tar.bz2
	mirror://flightgear/Shared/FlightGear-data-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="debug sdl"

COMMON_DEPEND="
	>=dev-games/openscenegraph-3.0.1[png]
	dev-vcs/subversion
	media-libs/freealut
	media-libs/openal
	sys-libs/zlib
	virtual/jpeg
	x11-libs/libXi
	x11-libs/libXmu
"
# Those provide either only C++ headers or static libraries
DEPEND="${COMMON_DEPEND}
	>=dev-libs/boost-1.37
	~dev-games/simgear-2.4.0
	>=media-libs/plib-1.8.5
"
RDEPEND="${COMMON_DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.0.0-sdl.patch \
		"${FILESDIR}"/${P}-svn.patch
	eautoreconf
}

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		--disable-glut \
		$(use_with debug logging) \
		$(use_enable sdl)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r ../data/* || die "doins failed"
	newicon ../data/Aircraft/A6M2/thumbnail.jpg ${PN}.jpg
	make_desktop_entry fgfs FlightGear /usr/share/pixmaps/${PN}.jpg
	dodoc AUTHORS ChangeLog NEWS README Thanks
	prepgamesdirs
}
