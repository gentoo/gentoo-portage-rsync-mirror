# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/clanbomber/clanbomber-2.1.1.ebuild,v 1.6 2012/11/15 11:43:55 tupone Exp $

EAPI=2
inherit autotools base eutils flag-o-matic games

DESCRIPTION="Bomberman-like multiplayer game"
HOMEPAGE="http://savannah.nongnu.org/projects/clanbomber/"
SRC_URI="http://download.savannah.gnu.org/releases/${PN}/${P}.tar.lzma"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

RDEPEND="media-libs/libsdl[audio,joystick,video]
	media-libs/sdl-image[png]
	media-libs/sdl-mixer
	media-libs/sdl-ttf
	media-libs/sdl-gfx
	dev-libs/boost
	media-fonts/dejavu"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( AUTHORS ChangeLog ChangeLog.hg IDEAS NEWS QUOTES README TODO )

src_prepare() {
	local boost_ver=$(best_version ">dev-libs/boost-1.49")

	boost_ver=${boost_ver/*boost-/}
	boost_ver=${boost_ver%.*}
	boost_ver=${boost_ver/./_}

	export BOOST_INCLUDEDIR="/usr/include/boost-${boost_ver}"
	export BOOST_LIBRARYDIR="/usr/$(get_libdir)/boost-${boost_ver}"
	sed -i -e 's/menuentry//' src/Makefile.am || die
	epatch \
		"${FILESDIR}"/${P}-automake112.patch \
		"${FILESDIR}"/${P}-boost150.patch
	eautoreconf
}

src_install() {
	base_src_install
	newicon src/pics/cup2.png ${PN}.png
	make_desktop_entry ${PN}2 ClanBomber2
	rm -f "${D}${GAMES_DATADIR}"/${PN}/fonts/DejaVuSans-Bold.ttf
	dosym /usr/share/fonts/dejavu/DejaVuSans-Bold.ttf \
		"${GAMES_DATADIR}"/${PN}/fonts/DejaVuSans-Bold.ttf
	prepgamesdirs
}
