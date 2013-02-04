# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/manaplus/manaplus-1.3.2.3.ebuild,v 1.1 2013/02/04 18:23:28 hasufell Exp $

EAPI=5

PLOCALES="cs de es fi fr id it ja nl_BE pl pt pt_BR ru zh_CN"
inherit autotools l10n games

DESCRIPTION="OpenSource 2D MMORPG client for Evol Online and The Mana World"
HOMEPAGE="http://manaplus.evolonline.org"
SRC_URI="http://download.evolonline.org/manaplus/download/${PV}/manaplus-${PV}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls opengl"

RDEPEND="
	>=dev-games/physfs-1.0.0
	dev-libs/libxml2
	media-libs/sdl-mixer[vorbis]
	media-libs/sdl-image[png]
	media-libs/sdl-net
	media-libs/sdl-ttf
	net-misc/curl
	sys-libs/zlib
	media-libs/libpng:0
	media-fonts/dejavu
	>=dev-games/guichan-0.8.1[sdl]
	media-libs/libsdl[X,opengl?,video]
	media-libs/sdl-gfx
	x11-apps/xmessage
	x11-libs/libX11
	x11-misc/xdg-utils
	x11-misc/xsel
	nls? ( virtual/libintl )
	opengl? ( virtual/opengl )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

src_prepare() {
	sed -i \
		-e '/^SUBDIRS/s/fonts//' \
		data/Makefile.am || die

	rm_locale() { sed -i "s:^${1}:#${1}:" po/LINGUAS || die ;}
	l10n_for_each_disabled_locale_do rm_locale

	rm -r src/guichan || die

	eautoreconf
}

src_configure() {
	egamesconf \
		--without-internalguichan \
		--localedir=/usr/share/locale \
		--disable-manaserv \
		--disable-eathena \
		$(use_with opengl) \
		$(use_enable nls)
}

src_install() {
	default

	dosym /usr/share/fonts/dejavu/DejaVuSans-Bold.ttf "${GAMES_DATADIR}"/${PN}/data/fonts/dejavusans-bold.ttf
	dosym /usr/share/fonts/dejavu/DejaVuSans.ttf "${GAMES_DATADIR}"/${PN}/data/fonts/dejavusans.ttf
	dosym /usr/share/fonts/dejavu/DejaVuSansMono.ttf "${GAMES_DATADIR}"/${PN}/data/fonts/dejavusans-mono.ttf
	insinto "${GAMES_DATADIR}"/${PN}/data

	prepgamesdirs
}
