# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/wxchtdecoder/wxchtdecoder-1.5a.ebuild,v 1.4 2015/02/05 07:09:07 mr_bones_ Exp $

EAPI=5
WX_GTK_VER="2.8"
inherit wxwidgets

DESCRIPTION="A program to decode .CHT files in Snes9x and ZSNES to plain text"
HOMEPAGE="http://games.technoplaza.net/chtdecoder/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="x11-libs/wxGTK:2.8[X]"
RDEPEND=${DEPEND}

src_configure() {
	econf --with-wx-config=${WX_CONFIG}
}

src_install() {
	dobin source/wxchtdecoder
	dodoc docs/wxchtdecoder.txt
}
