# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/hexxagon/hexxagon-1.0.1.ebuild,v 1.8 2012/07/07 23:10:25 tristan Exp $

EAPI=2
inherit eutils games

DESCRIPTION="Clone of the original DOS game"
HOMEPAGE="http://www.nesqi.se/"
SRC_URI="http://www.nesqi.se/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="dev-cpp/glibmm:2
	dev-cpp/gtkmm:2.4
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

PATCHES=( "${FILESDIR}"/${P}-gcc47.patch )

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	newicon images/board_N_2.xpm ${PN}.xpm
	make_desktop_entry ${PN} Hexxagon
	dodoc README
	prepgamesdirs
}
