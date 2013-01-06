# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/cuyo/cuyo-2.1.1.ebuild,v 1.6 2012/09/01 05:05:39 mr_bones_ Exp $

EAPI=2
inherit autotools eutils gnome2-utils versionator games

MY_P=${PN}-$(get_version_component_range 1).~-$(get_version_component_range 2-3)
DESCRIPTION="highly addictive and remotely related to tetris"
HOMEPAGE="http://www.karimmi.de/cuyo/"
SRC_URI="http://savannah.nongnu.org/download/cuyo/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="+music"

DEPEND="sys-libs/zlib
	media-libs/libsdl[audio,video]
	media-libs/sdl-mixer
	music? ( media-libs/sdl-mixer[mod] )
	media-libs/sdl-image"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-gcc44.patch \
		"${FILESDIR}"/${P}-gentoo.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
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
