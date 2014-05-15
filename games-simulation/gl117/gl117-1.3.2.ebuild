# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/gl117/gl117-1.3.2.ebuild,v 1.13 2014/05/15 17:00:16 ulm Exp $

EAPI=2
inherit eutils games

MY_P="gl-117-${PV}-src"
DESCRIPTION="An action flight simulator"
HOMEPAGE="http://www.heptargon.de/gl-117/gl-117.html"
SRC_URI="mirror://sourceforge/gl-117/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="media-libs/libsdl[sound,joystick,opengl,video]
	media-libs/sdl-mixer[mod]
	virtual/opengl
	virtual/glu
	media-libs/freeglut"

S=${WORKDIR}/${MY_P}

PATCHES=( "${FILESDIR}"/${P}-mode.patch )

src_install() {
	emake DESTDIR="${D}" install || die
	newicon doc/src/falcon.jpg ${PN}.jpg
	make_desktop_entry gl-117 GL-117 /usr/share/pixmaps/${PN}.jpg
	doman doc/gl-117.6
	dodoc doc/gl-117.pdf AUTHORS ChangeLog FAQ NEWS README
	prepgamesdirs
}
