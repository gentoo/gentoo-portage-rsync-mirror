# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/cuyo/cuyo-2.0.0.ebuild,v 1.1 2015/02/18 22:31:39 mr_bones_ Exp $

EAPI=5
inherit autotools eutils gnome2-utils games

DESCRIPTION="highly addictive and remotely related to tetris"
HOMEPAGE="http://www.karimmi.de/cuyo/"
SRC_URI="http://savannah.nongnu.org/download/cuyo/${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="+music"

RDEPEND="sys-libs/zlib
	media-libs/libsdl[sound,video]
	media-libs/sdl-mixer
	music? ( media-libs/sdl-mixer[mod] )
	media-libs/sdl-image
	virtual/libintl"
DEPEND="${RDEPEND}
	sys-devel/gettext"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.patch
	eautoreconf
}

src_install() {
	default
	prepgamesdirs
}

pkg_preinst() {
	games_pkg_preinst
	gnome2_icon_savelist
}

pkg_postinst() {
	games_pkg_postinst
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
