# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/stoned-bin/stoned-bin-1.1.6.ebuild,v 1.6 2010/09/16 17:00:23 scarabeus Exp $

inherit games

DESCRIPTION="3D curling simulation"
HOMEPAGE="http://stoned.cute-ninjas.com/"
SRC_URI="http://stoned.cute-ninjas.com/download/${P/-bin}-i386-linux.tar.gz"

LICENSE="as-is"
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

S=${WORKDIR}/${P/-bin}-i386-linux

src_install() {
	into "${GAMES_PREFIX_OPT}"
	dobin stoned || die "dobin failed"
	dodoc FAQ README
	prepgamesdirs
}
