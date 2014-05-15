# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/lincity-ng/lincity-ng-2.0.ebuild,v 1.10 2014/05/15 17:00:45 ulm Exp $

EAPI=2
inherit eutils multiprocessing games

DESCRIPTION="city/country simulation game for X and opengl"
HOMEPAGE="http://lincity-ng.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"

LICENSE="GPL-2 BitstreamVera"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE=""

RDEPEND="virtual/opengl
	sys-libs/zlib
	dev-libs/libxml2
	media-libs/libsdl[sound,joystick,opengl,video]
	media-libs/sdl-mixer[vorbis]
	media-libs/sdl-image[png]
	media-libs/sdl-ttf
	media-libs/sdl-gfx
	dev-games/physfs"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	dev-util/ftjam"

src_prepare() {
	epatch "${FILESDIR}"/${P}-build.patch
}

src_compile() {
	jam -q -dx -j $(makeopts_jobs) || die "jam failed"
}

src_install() {
	jam -sDESTDIR="${D}" \
		 -sappdocdir="/usr/share/doc/${PF}" \
		 -sapplicationsdir="/usr/share/applications" \
		 -spixmapsdir="/usr/share/pixmaps" \
		 install \
		 || die "jam install failed"
	rm -f "${D}"/usr/share/doc/${PF}/COPYING*
	prepalldocs
	prepgamesdirs
}
