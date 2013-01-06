# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/criticalmass/criticalmass-1.0.2.ebuild,v 1.7 2012/09/05 07:17:50 mr_bones_ Exp $

EAPI=2
inherit autotools eutils games

DESCRIPTION="SDL/OpenGL space shoot'em up game"
HOMEPAGE="http://criticalmass.sourceforge.net/"
SRC_URI="mirror://sourceforge/criticalmass/CriticalMass-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="media-libs/sdl-mixer
	media-libs/sdl-image[png]
	media-libs/libpng
	virtual/opengl
	net-misc/curl"

S=${WORKDIR}/CriticalMass-${PV}

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc43.patch \
		"${FILESDIR}"/${P}-system_curl.patch \
		"${FILESDIR}"/${P}-libpng14.patch \
		"${FILESDIR}"/${P}-cflags.patch \
		"${FILESDIR}"/${P}-libpng15.patch
	rm -rf curl
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	rm -f "${D}${GAMES_BINDIR}/Packer"
	dohtml Readme.html
	dodoc TODO
	newicon critter.png ${PN}.png
	make_desktop_entry critter "Critical Mass"
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	if ! has_version "media-libs/sdl-mixer[mod]" ; then
		ewarn
		ewarn "To hear music, you will have to rebuild media-libs/sdl-mixer"
		ewarn "with the \"mod\" USE flag turned on."
		ewarn
	fi
}
