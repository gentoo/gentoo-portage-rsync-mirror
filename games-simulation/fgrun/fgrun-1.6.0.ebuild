# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/fgrun/fgrun-1.6.0.ebuild,v 1.1 2012/01/21 15:57:35 reavertm Exp $

EAPI=3
inherit autotools eutils multilib games

DESCRIPTION="A graphical frontend for the FlightGear Flight Simulator"
HOMEPAGE="http://sourceforge.net/projects/fgrun"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEPEND="
	>=dev-games/openscenegraph-3.0.1
	sys-libs/zlib
	x11-libs/fltk:1[opengl,threads]
"
DEPEND="${COMMON_DEPEND}
	>=dev-games/simgear-2
	>=dev-libs/boost-1.34
"
RDEPEND="${COMMON_DEPEND}
	>=games-simulation/flightgear-2
"

src_prepare() {
	epatch "${FILESDIR}/${PN}-1.5.2-fltk.patch"
	AT_M4DIR=. eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS NEWS
	prepgamesdirs
}
