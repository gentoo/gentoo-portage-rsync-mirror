# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/blokish/blokish-0.9.4-r1.ebuild,v 1.8 2012/10/12 15:40:43 mr_bones_ Exp $

EAPI=2
WX_GTK_VER="2.8"
inherit eutils autotools wxwidgets games

MY_P="${PN}_v${PV}"
DESCRIPTION="Open source clone of the four-player board game Blokus"
HOMEPAGE="http://sourceforge.net/projects/blokish/"
SRC_URI="mirror://sourceforge/blokish/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="x11-libs/wxGTK:2.8[X,opengl]
	virtual/glu
	virtual/opengl"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc43.patch \
		"${FILESDIR}"/${P}-underlink.patch
	sed -i \
		-e "s:wx-config:${WX_CONFIG}:" \
		configure.in makefile.am \
		|| die "sed failed"
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	doicon src/${PN}.xpm
	make_desktop_entry ${PN} Blokish ${PN}

	dodoc AUTHORS ChangeLog README
	dohtml docs/*
	prepgamesdirs
}
