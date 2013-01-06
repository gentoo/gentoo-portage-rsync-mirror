# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/xbubble/xbubble-0.5.8.ebuild,v 1.16 2011/09/14 08:11:24 tupone Exp $

EAPI=2
inherit eutils games

DESCRIPTION="a Puzzle Bobble clone similar to Frozen-Bubble"
HOMEPAGE="http://www.nongnu.org/xbubble/"
SRC_URI="http://www.ibiblio.org/pub/mirrors/gnu/ftp/savannah/files/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc x86"
IUSE="nls"

RDEPEND="x11-libs/libX11
	x11-libs/libXt
	media-libs/libpng
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-xpaths.patch \
		"${FILESDIR}"/${P}-locale.patch \
		"${FILESDIR}"/${P}-libpng14.patch \
		"${FILESDIR}"/${P}-png15.patch
	sed -i \
		-e '/^AM_CFLAGS/d' \
		src/Makefile.in || die "sed cflags"
	sed -i \
		-e '/^localedir/s:=.*:=/usr/share/locale:' \
		configure po/Makefile.in.in || die "sed locale"
}

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		$(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	newicon data/themes/fancy/Bubble_black_DEAD_01.png ${PN}.png
	make_desktop_entry ${PN} XBubble
	dodoc AUTHORS ChangeLog NEWS NetworkProtocol README TODO
	prepgamesdirs
}
