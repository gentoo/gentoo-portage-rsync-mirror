# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/gnujump/gnujump-1.0.8.ebuild,v 1.1 2013/04/26 01:03:52 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="Xjump clone with added features"
HOMEPAGE="http://gnujump.es.gnu.org"
SRC_URI="ftp://ftp.gnu.org/gnu/gnujump/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-image[png]
	media-libs/sdl-mixer[vorbis]
	virtual/opengl
	x11-libs/libX11"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README

	newicon skins/xjump/hero1.0.png ${PN}.png
	make_desktop_entry ${PN} "GNUjump"

	prepgamesdirs
}
