# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/gngeo/gngeo-0.7.ebuild,v 1.7 2012/09/04 05:07:50 tupone Exp $
EAPI=2

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

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-build.patch \
		"${FILESDIR}"/${P}-execstacks.patch \
		"${FILESDIR}"/${P}-concurrentMake.patch \
		"${FILESDIR}"/${P}-zlib.patch

	eautoreconf
}

src_configure() {
	egamesconf --disable-i386asm || die "egamesconf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS FAQ NEWS README* TODO sample_gngeorc
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	elog "A licensed NeoGeo BIOS copy is required to run the emulator."
	echo
}
