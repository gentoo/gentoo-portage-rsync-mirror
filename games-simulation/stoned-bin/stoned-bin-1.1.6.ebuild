# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/stoned-bin/stoned-bin-1.1.6.ebuild,v 1.8 2015/03/23 06:29:31 mr_bones_ Exp $

EAPI=5
inherit games

DESCRIPTION="3D curling simulation"
HOMEPAGE="http://stoned.cute-ninjas.com/"
SRC_URI="http://stoned.cute-ninjas.com/download/${P/-bin}-i386-linux.tar.gz"

LICENSE="public-domain no-source-code"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""
RESTRICT="strip"

RDEPEND="virtual/opengl
	media-libs/freeglut
	media-libs/sdl-net
	=media-libs/fmod-3*
	sys-libs/zlib
	media-libs/libpng"
DEPEND=${RDEPEND}

S=${WORKDIR}/${P/-bin}-i386-linux

src_install() {
	into "${GAMES_PREFIX_OPT}"
	dobin stoned
	dodoc FAQ README
	prepgamesdirs
}
