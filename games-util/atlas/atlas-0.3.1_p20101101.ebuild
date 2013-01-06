# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/atlas/atlas-0.3.1_p20101101.ebuild,v 1.3 2011/08/09 17:29:42 ssuominen Exp $

EAPI=2
inherit autotools eutils games

DESCRIPTION="Chart Program to use with Flightgear Flight Simulator"
HOMEPAGE="http://atlas.sourceforge.net/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=games-simulation/flightgear-2
	media-libs/freeglut
	>=media-libs/libpng-1.4
	media-libs/plib
	net-misc/curl
	virtual/glu
	virtual/jpeg
	virtual/opengl
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXi
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libXt
	x11-libs/libXmu"

src_prepare() {
	epatch "${FILESDIR}"/${P}-libpng15.patch
	eautoreconf
}

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		--with-fgbase="${GAMES_DATADIR}"/FlightGear
}

src_install() {
	emake DESTDIR="${D}" install || die
	insinto "${GAMES_DATADIR}"/FlightGear/Atlas
	doins src/data/*.{jpg,png} || die
	insinto "${GAMES_DATADIR}"/FlightGear/Atlas/Palettes
	doins src/data/Palettes/*.ap || die
	insinto "${GAMES_DATADIR}"/FlightGear/Atlas/Fonts
	doins src/data/Fonts/*.txf || die
	dodoc AUTHORS NEWS README
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "You now can make the maps with the following commands:"
	elog "${GAMES_BINDIR}/Map --atlas=${GAMES_DATADIR}/FlightGear/Atlas"
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
	elog "${GAMES_DATADIR}/FlightGear/Atlas"
	echo
}
