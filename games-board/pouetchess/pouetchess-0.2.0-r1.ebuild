# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/pouetchess/pouetchess-0.2.0-r1.ebuild,v 1.12 2011/04/28 07:43:24 mr_bones_ Exp $

EAPI=2
inherit eutils scons-utils games

MY_PN=${PN/c/C}
DESCRIPTION="3D and open source chess game"
HOMEPAGE="http://pouetchess.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}_src_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="debug"

DEPEND="media-libs/libsdl
	media-libs/sdl-image[jpeg,png]
	virtual/glu
	virtual/opengl"

S=${WORKDIR}/${PN}_src_${PV}

PATCHES=( "${FILESDIR}/${P}-sconstruct-sandbox.patch"
	"${FILESDIR}/${P}-nvidia_glext.patch"
	"${FILESDIR}/${P}-segfaults.patch"
	"${FILESDIR}/${P}-gcc43.patch" )

src_prepare() {
	epatch "${PATCHES[@]}"
	# Fix for LibSDL >= 1.2.10 detection
	sed -i \
		-e "s:sdlver.split('.') >= \['1','2','8'\]:sdlver.split('.') >= [1,2,8]:" \
		pouetChess.py \
		|| die "sed failed"
}

src_configure() {
	# turn off the hackish optimization setting code (bug #230127)
	scons configure \
		strip=false \
		optimize=false \
		prefix="${GAMES_PREFIX}" \
		datadir="${GAMES_DATADIR}"/${PN} \
		$(use debug && echo debug=1) \
		|| die "scons configure failed"
}

src_compile() {
	escons || die
}

src_install() {
	dogamesbin bin/${MY_PN} || die "dogamesbin failed"

	insinto "${GAMES_DATADIR}"/${PN}
	doins -r data/* || die "doins failed"

	dodoc ChangeLog README

	doicon data/icons/${MY_PN}.png
	make_desktop_entry ${MY_PN} ${MY_PN} ${MY_PN} "KDE;Qt;Game;BoardGame"

	prepgamesdirs
}
