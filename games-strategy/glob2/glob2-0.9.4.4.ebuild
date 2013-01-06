# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/glob2/glob2-0.9.4.4.ebuild,v 1.7 2012/11/07 10:29:13 tupone Exp $

EAPI=4
inherit eutils scons-utils games

DESCRIPTION="Real Time Strategy (RTS) game involving a brave army of globs"
HOMEPAGE="http://globulation2.org/"
SRC_URI="http://dl.sv.nongnu.org/releases/glob2/0.9.4/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND="virtual/opengl
	virtual/glu
	>=dev-libs/boost-1.34
	media-libs/libsdl[opengl]
	media-libs/sdl-net
	media-libs/sdl-ttf
	media-libs/sdl-image[png]
	media-libs/libvorbis
	dev-libs/fribidi
	media-libs/speex"

PATCHES=( "${FILESDIR}"/${P}-gcc44.patch "${FILESDIR}"/${P}-scons-blows.patch )

src_configure() {
	myesconsargs=(
		INSTALLDIR="${GAMES_DATADIR}"/${PN}
		DATADIR="${GAMES_DATADIR}"/${PN}
	)
	escons data
}

src_compile() {
	escons
}

src_install() {
	dogamesbin src/${PN}
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r campaigns data maps scripts
	find "${D}/${GAMES_DATADIR}"/${PN} -name SConscript -exec rm -f {} +
	newicon data/icons/glob2-icon-48x48.png ${PN}.png
	make_desktop_entry glob2 "Globulation 2"
	dodoc README*
	prepgamesdirs
}
