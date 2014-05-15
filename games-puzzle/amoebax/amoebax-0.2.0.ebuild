# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/amoebax/amoebax-0.2.0.ebuild,v 1.9 2014/05/15 16:48:41 ulm Exp $

EAPI=2
inherit autotools eutils games

DESCRIPTION="a cute and addictive action-puzzle game, similar to tetris"
HOMEPAGE="http://www.emma-soft.com/games/amoebax/"
SRC_URI="http://www.emma-soft.com/games/amoebax/download/${P}.tar.bz2"

LICENSE="FreeArt GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="media-libs/libsdl[sound,joystick,video]
	media-libs/sdl-image[png]
	media-libs/sdl-mixer[vorbis]"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-gcc43.patch \
		"${FILESDIR}"/${P}-glibc2.10.patch \
		"${FILESDIR}"/${P}-aclocal.patch
	sed -i \
		-e "/^SUBDIRS/s:doc ::" \
		Makefile.am || die
	sed -i \
		-e "/^iconsdir/s:=.*:=/usr/share/pixmaps:" \
		-e "/^desktopdir/s:=.*:=/usr/share/applications:" \
		data/Makefile.am || die
	sed -i \
		-e '/Encoding/d' \
		-e '/Icon/s/.svg//' \
		data/amoebax.desktop || die
	AT_M4DIR=m4 eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS NEWS README TODO
	prepgamesdirs
}
