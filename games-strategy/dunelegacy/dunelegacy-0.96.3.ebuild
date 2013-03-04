# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/dunelegacy/dunelegacy-0.96.3.ebuild,v 1.1 2013/03/04 16:32:18 hasufell Exp $

EAPI=5
inherit autotools eutils gnome2-utils games

DESCRIPTION="Updated clone of Westood Studios' Dune2"
HOMEPAGE="http://dunelegacy.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="+alsa pulseaudio"

RDEPEND="media-libs/libsdl[X,alsa?,audio,pulseaudio?,video]
	media-libs/sdl-mixer[midi,mp3,vorbis]"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

# exits on start without libsdl[alsa] or libsdl[pulseaudio]
REQUIRED_USE="|| ( alsa pulseaudio )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-build.patch
	eautoreconf
}

src_install() {
	default

	doicon -s scalable ${PN}.svg
	doicon -s 48 ${PN}.png
	make_desktop_entry ${PN} "Dune Legacy"

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
