# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/enigma/enigma-1.20.ebuild,v 1.2 2013/05/08 19:44:45 mr_bones_ Exp $

EAPI=5
inherit autotools eutils gnome2-utils games

DESCRIPTION="puzzle game similar to Oxyd"
HOMEPAGE="http://www.nongnu.org/enigma/"
SRC_URI="mirror://sourceforge/enigma-game/${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="nls"

COMMON_DEPS="media-libs/sdl-ttf
	media-libs/libsdl[video]
	media-libs/sdl-mixer
	media-libs/sdl-image[jpeg,png]
	media-libs/libpng:0=
	sys-libs/zlib
	net-misc/curl
	|| ( >=dev-libs/xerces-c-3[icu] >=dev-libs/xerces-c-3[-icu,-iconv] )
	net-libs/enet:0
	media-fonts/dejavu
	nls? ( virtual/libintl )"
DEPEND="${COMMON_DEPS}
	sys-devel/gettext"
RDEPEND="${COMMON_DEPS}
	x11-misc/xdg-utils"

src_prepare() {
	rm -rf lib-src/enet
	cp /usr/share/gettext/config.rpath .
	epatch "${FILESDIR}"/${P}-autotools.patch
	sed -i \
		-e "s:DOCDIR:\"/usr/share/doc/${P}/html\":" \
		src/main.cc || die
	eautoreconf
}

src_configure() {
	egamesconf $(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install
	#rm -f "${GAMES_DATADIR}"/${PN}/fonts/DejaVuSansCondensed.ttf
	dosym \
		/usr/share/fonts/dejavu/DejaVuSansCondensed.ttf \
		"${GAMES_DATADIR}"/${PN}/fonts/DejaVuSansCondensed.ttf
	dodoc ACKNOWLEDGEMENTS AUTHORS CHANGES README doc/HACKING
	dohtml -r doc/*
	doman doc/enigma.6
	prepgamesdirs
}

pkg_preinst() {
	games_pkg_preinst
	gnome2_icon_savelist
}

pkg_postinst() {
	games_pkg_postinst
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
