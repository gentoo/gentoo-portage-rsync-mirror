# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/crashtest/crashtest-1.1.ebuild,v 1.5 2014/04/10 06:33:20 mr_bones_ Exp $

EAPI=5
inherit eutils flag-o-matic games

DESCRIPTION="Educational car crash simulator"
HOMEPAGE="http://www.stolk.org/crashtest/"
SRC_URI="http://www.stolk.org/crashtest/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="
	x11-libs/fltk:1[opengl]
	dev-games/ode
	media-libs/alsa-lib
	virtual/opengl
	virtual/glu
	media-libs/freeglut"
DEPEND="${RDEPEND}
	>=media-libs/plib-1.8.4"

S=${WORKDIR}/${P}/src-${PN}

src_prepare() {
	epatch "${FILESDIR}/${P}"-gentoo.patch
	sed -i \
		-e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}/${PN}:" \
		-e "s:@GENTOO_BINDIR@:${GAMES_BINDIR}:" \
		Makefile ${PN}.cxx \
		|| die "sed failed"
	append-flags -DHAVE_ISNANF
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc README
	make_desktop_entry ${PN} Crashtest
	prepgamesdirs
}
