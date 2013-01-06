# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/wxchtdecoder/wxchtdecoder-1.5a.ebuild,v 1.3 2009/10/20 12:59:19 maekke Exp $

EAPI=2
WX_GTK_VER="2.8"
inherit wxwidgets

DESCRIPTION="A program to decode .CHT files in Snes9x and ZSNES to plain text"
HOMEPAGE="http://games.technoplaza.net/chtdecoder/"
SRC_URI="http://games.technoplaza.net/chtdecoder/wx/history/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="x11-libs/wxGTK:2.8[X]"

src_configure() {
	econf --with-wx-config=${WX_CONFIG}
}

src_install() {
	dobin source/wxchtdecoder || die "dobin failed"
	dodoc docs/wxchtdecoder.txt
}
