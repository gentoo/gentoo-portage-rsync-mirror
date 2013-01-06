# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/gfifteen/gfifteen-1.0.3.ebuild,v 1.3 2012/08/02 21:24:09 hwoarang Exp $

EAPI=2
inherit eutils games

DESCRIPTION="graphical implementation of the sliding puzzle game fifteen"
HOMEPAGE="https://frigidcode.com/code/gfifteen/"
SRC_URI="https://frigidcode.com/code/gfifteen/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		--disable-assembly || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README ChangeLog || die
	doicon ${PN}.svg
	domenu gfifteen.desktop
	prepgamesdirs
}
