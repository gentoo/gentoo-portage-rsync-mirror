# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/atlas/atlas-0.3.1_p20101101-r1.ebuild,v 1.2 2011/10/16 03:32:27 reavertm Exp $

EAPI=3
inherit autotools eutils games

DESCRIPTION="Chart Program to use with Flightgear Flight Simulator"
HOMEPAGE="http://atlas.sourceforge.net/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

COMMON_DEPEND="
	media-libs/freeglut
	>=media-libs/libpng-1.4
	net-misc/curl
	sys-libs/zlib
	virtual/glu
	virtual/jpeg
	virtual/opengl
"
DEPEND="${COMMON_DEPEND}
	>=dev-games/simgear-2.4.0
	media-libs/plib
"
RDEPEND="${COMMON_DEPEND}
	>=games-simulation/flightgear-2.4.0
"

src_prepare() {
	epatch "${FILESDIR}"/${P}-libpng15.patch
	epatch "${FILESDIR}"/${P}-simgear-2.4.0.patch
	eautoreconf
}

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		--with-fgbase="${GAMES_DATADIR}"/flightgear
}

src_install() {
	emake DESTDIR="${D}" install || die
	insinto "${GAMES_DATADIR}"/flightgear/Atlas
	doins src/data/*.{jpg,png} || die
	insinto "${GAMES_DATADIR}"/flightgear/Atlas/Palettes
	doins src/data/Palettes/*.ap || die
	insinto "${GAMES_DATADIR}"/flightgear/Atlas/Fonts
	doins src/data/Fonts/*.txf || die
	dodoc AUTHORS NEWS README
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "You now can make the maps with the following commands:"
	elog "${GAMES_BINDIR}/Map --atlas=${GAMES_DATADIR}/flightgear/Atlas"
	elog
	elog "To run Atlas concurrently with FlightGear use the following:"
	elog "Atlas --path=[path of map images] --udp=[port number]"
	elog "and start fgfs with the following switch (or in .fgfsrc):"
	elog "--nmea=socket,out,0.5,[host that you run Atlas on],[port number],udp"
	echo
}

pkg_postrm() {
	elog "You must manually remove the maps if you don't want them around."
	elog "They are found in the following directory:"
	echo
	elog "${GAMES_DATADIR}/flightgear/Atlas"
	echo
}
