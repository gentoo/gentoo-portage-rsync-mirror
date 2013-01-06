# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/skystreets/skystreets-0.2.4.ebuild,v 1.6 2009/02/02 17:05:33 tupone Exp $

EAPI=2
inherit eutils games

DESCRIPTION="A remake of the old DOS game Skyroads"
HOMEPAGE="http://skystreets.kaosfusion.com/"
SRC_URI="http://skystreets.kaosfusion.com/${P}.tar.bz2"

LICENSE="OSL-2.0"
SLOT="0"
KEYWORDS="alpha amd64 ppc x86"
IUSE=""

DEPEND="virtual/opengl
	virtual/glu
	media-libs/libsdl
	media-libs/sdl-image"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-gl.patch \
		"${FILESDIR}"/${P}-as-needed.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	newicon gfx/sunscene.png ${PN}.png
	make_desktop_entry ${PN} SkyStreets
	dodoc AUTHORS BUGS CODE ChangeLog README TODO
	prepgamesdirs
}
