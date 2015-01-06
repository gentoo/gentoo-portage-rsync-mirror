# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/gnujump/gnujump-1.0.6.ebuild,v 1.3 2015/01/06 10:49:25 tupone Exp $

EAPI=5
inherit eutils games

DESCRIPTION="Xjump clone with added features"
HOMEPAGE="http://gnujump.es.gnu.org"
SRC_URI="mirror://gnu/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-image[png]
	media-libs/sdl-mixer[vorbis]
	virtual/opengl
	x11-libs/libX11"
RDEPEND="${DEPEND}"

src_install() {
	default
	newicon skins/xjump/hero1.0.png ${PN}.png
	make_desktop_entry ${PN} "GNUjump"

	prepgamesdirs
}
