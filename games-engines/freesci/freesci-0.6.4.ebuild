# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/freesci/freesci-0.6.4.ebuild,v 1.6 2015/01/18 15:39:18 tupone Exp $

EAPI=5
inherit eutils games

DESCRIPTION="Sierra script interpreter for your old Sierra adventures"
HOMEPAGE="http://freesci.linuxgames.com/"
SRC_URI="http://www-plan.cs.colorado.edu/creichen/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="X ggi sdl"

DEPEND="media-libs/alsa-lib
	X? (
		x11-libs/libX11
		x11-libs/libXrender
		x11-libs/libXext
	)
	ggi? ( media-libs/libggi )
	sdl? ( media-libs/libsdl )"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i \
		-e "/^SUBDIRS =/s:desktop src conf debian:src:" \
		Makefile.in \
		|| die "sed failed"
	epatch "${FILESDIR}"/${P}-glibc2.10.patch
}

src_configure() {
	egamesconf \
		--with-Wall \
		--without-directfb \
		$(use_with X x) \
		$(use_with ggi) \
		$(use_with sdl)
}

src_install() {
	default
	doicon desktop/${PN}.png
	make_desktop_entry ${PN} FreeSCI
	prepgamesdirs
}
