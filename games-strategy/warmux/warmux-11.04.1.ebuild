# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/warmux/warmux-11.04.1.ebuild,v 1.7 2012/11/05 16:58:48 mr_bones_ Exp $

EAPI=2
inherit autotools eutils games

DESCRIPTION="A free Worms clone"
HOMEPAGE="http://gna.org/projects/warmux/"
SRC_URI="http://download.gna.org/warmux/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="debug nls unicode"

RDEPEND="media-libs/libsdl[joystick,video]
	media-libs/sdl-image[jpeg,png]
	media-libs/sdl-mixer[vorbis]
	media-libs/sdl-ttf
	media-libs/sdl-net
	>=media-libs/sdl-gfx-2.0.22
	net-misc/curl
	media-fonts/dejavu
	dev-libs/libxml2
	x11-libs/libX11
	nls? ( virtual/libintl )
	unicode? ( dev-libs/fribidi )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${PN}-11.04

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-gentoo.patch \
		"${FILESDIR}"/${P}-zlib.patch \
		"${FILESDIR}"/${P}-action.patch \
		"${FILESDIR}"/${P}-gcc47.patch
	eautoreconf
}

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		--with-localedir-name=/usr/share/locale \
		--with-datadir-name="${GAMES_DATADIR}/${PN}" \
		--with-font-path=/usr/share/fonts/dejavu/DejaVuSans.ttf \
		$(use_enable debug) \
		$(use_enable nls) \
		$(use_enable unicode fribidi)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README TODO
	rm -f "${D}${GAMES_DATADIR}/${PN}/font/DejaVuSans.ttf"
	doicon data/icon/warmux.svg || die
	make_desktop_entry warmux Warmux || die
	prepgamesdirs
}
