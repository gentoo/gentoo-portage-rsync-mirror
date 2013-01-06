# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/enigma/enigma-1.01.ebuild,v 1.17 2012/09/28 12:24:34 tupone Exp $

EAPI=2
inherit autotools eutils games

DESCRIPTION="puzzle game similar to Oxyd"
HOMEPAGE="http://www.nongnu.org/enigma/"
SRC_URI="mirror://berlios/enigma-game/${P}-64bit.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="nls"

RDEPEND="media-libs/sdl-ttf
	media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-image[jpeg,png]
	media-libs/libpng
	|| ( >=dev-libs/xerces-c-3[icu] >=dev-libs/xerces-c-3[-icu,-iconv] )
	net-libs/enet:0
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	sys-devel/gettext"

src_prepare() {
	cp /usr/share/gettext/config.rpath .
	epatch \
		"${FILESDIR}"/${P}-autotools.patch \
		"${FILESDIR}"/${P}-gcc43.patch \
		"${FILESDIR}"/${P}-gcc44.patch \
		"${FILESDIR}"/${P}-gcc46.patch \
		"${FILESDIR}"/${P}-gcc47.patch \
		"${FILESDIR}"/${P}-xerces-c.patch \
		"${FILESDIR}"/${P}-libpng15.patch
	eautoreconf
}

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		$(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ACKNOWLEDGEMENTS AUTHORS CHANGES README doc/HACKING
	dohtml -r doc/*
	doman doc/enigma.6
	prepgamesdirs
}
