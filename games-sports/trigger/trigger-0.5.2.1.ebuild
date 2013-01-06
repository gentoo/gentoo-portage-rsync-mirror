# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/trigger/trigger-0.5.2.1.ebuild,v 1.8 2010/09/30 15:41:38 tupone Exp $

EAPI=2
inherit eutils games

DATA_V=0.5.2
DESCRIPTION="Free OpenGL rally car racing game"
HOMEPAGE="http://www.positro.net/trigger/"
SRC_URI="mirror://sourceforge/${PN}-rally/${P}-src.tar.bz2
	mirror://sourceforge/${PN}-rally/${PN}-${DATA_V}-data.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND="virtual/opengl
	virtual/glu
	media-libs/libsdl
	media-libs/sdl-image[jpeg,png]
	media-libs/sdl-mixer
	media-libs/openal
	media-libs/freealut
	dev-games/physfs"
DEPEND="${RDEPEND}
	dev-util/ftjam"

S=${WORKDIR}/${P}-src

PATCHES=( "${FILESDIR}"/${P}-ldflags.patch )

src_configure() {
	egamesconf --datadir="${GAMES_DATADIR}"/${PN} || die
}

src_compile() {
	jam -qa || die "jam failed"
}

src_install() {
	dogamesbin trigger || die "dogamesbin failed"
	cd ../${PN}-${DATA_V}-data
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r events maps plugins sounds textures vehicles trigger.config.defs \
		|| die "doins failed"
	newicon textures/life_helmet.png ${PN}.png
	make_desktop_entry ${PN} Trigger
	dodoc README.txt README-stereo.txt
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "After running ${PN} for the first time, a config file is"
	elog "available in ~/.trigger/trigger.config"
}
