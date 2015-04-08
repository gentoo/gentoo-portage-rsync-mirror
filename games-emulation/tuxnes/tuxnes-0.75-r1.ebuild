# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/tuxnes/tuxnes-0.75-r1.ebuild,v 1.3 2009/11/19 12:38:38 tupone Exp $

EAPI=2
inherit autotools eutils games

DESCRIPTION="emulator for the 8-bit Nintendo Entertainment System"
HOMEPAGE="http://tuxnes.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="X ggi"

RDEPEND="X? (
		x11-libs/libXext
		x11-libs/libICE
		x11-libs/libX11
		x11-libs/libXpm
		x11-libs/libSM )
	ggi? ( >=media-libs/libggi-2.0.1 )"
DEPEND="${RDEPEND}
	X? (
		x11-proto/xextproto
		x11-proto/xproto )"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-configure.in.patch \
		"${FILESDIR}"/${P}-gcc34.patch \
		"${FILESDIR}"/${P}-gcc43.patch \
		"${FILESDIR}"/${P}-include.patch \
		"${FILESDIR}"/${P}-exec-stack.patch \
		"${FILESDIR}"/${P}-xshm.patch
	eautoreconf
}

src_configure() {
	egamesconf \
		--without-w \
		$(use_with ggi) \
		$(use_with X x)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	doicon tuxnes.xpm tuxnes2.xpm
	dodoc AUTHORS BUGS ChangeLog CHANGES NEWS README THANKS
	prepgamesdirs
}
