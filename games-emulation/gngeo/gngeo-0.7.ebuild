# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/gngeo/gngeo-0.7.ebuild,v 1.8 2015/01/17 16:28:18 tupone Exp $
EAPI=5

inherit eutils autotools games

DESCRIPTION="A NeoGeo emulator"
HOMEPAGE="http://m.peponas.free.fr/gngeo/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND="virtual/opengl
	media-libs/sdl-image
	media-libs/libsdl
	sys-libs/zlib[minizip]"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-build.patch \
		"${FILESDIR}"/${P}-execstacks.patch \
		"${FILESDIR}"/${P}-concurrentMake.patch \
		"${FILESDIR}"/${P}-zlib.patch
	mv configure.{in,ac}
	eautoreconf
}

src_configure() {
	egamesconf --disable-i386asm
}

src_install() {
	default
	dodoc sample_gngeorc
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	elog "A licensed NeoGeo BIOS copy is required to run the emulator."
	echo
}
