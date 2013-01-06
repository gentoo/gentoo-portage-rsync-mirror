# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gmchess/gmchess-0.29.6.ebuild,v 1.4 2012/02/16 19:15:48 phajdan.jr Exp $

EAPI=2
inherit games

DESCRIPTION="Chinese chess with gtkmm and c++"
HOMEPAGE="http://code.google.com/p/gmchess/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.bz2"
RESTRICT="test"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-cpp/gtkmm:2.4"

src_prepare() {
	sed -i -e '/Encoding=/d' data/${PN}.desktop.in || die
}

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		--disable-static \
		--localedir='/usr/share/locale' || die
}

src_install() {
	emake DESTDIR="${D}" \
		itlocaledir='/usr/share/locale' \
		pixmapsdir='/usr/share/pixmaps' \
		desktopdir='/usr/share/applications' \
		install || die
	dodoc AUTHORS NEWS README
	find "${D}" -name '*.la' -exec rm -f '{}' +
	prepgamesdirs
}
