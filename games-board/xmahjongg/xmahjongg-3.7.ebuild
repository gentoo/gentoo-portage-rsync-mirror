# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/xmahjongg/xmahjongg-3.7.ebuild,v 1.8 2010/01/03 11:46:07 fauli Exp $

inherit eutils games

DESCRIPTION="friendly GUI version of xmahjongg"
HOMEPAGE="http://www.lcdf.org/xmahjongg/"
SRC_URI="http://www.lcdf.org/xmahjongg/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~mips ppc x86 ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

RDEPEND="x11-libs/libSM
	x11-libs/libX11
	media-libs/libpng
	sys-libs/zlib"
DEPEND="${RDEPEND}
	x11-libs/libXt"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	newicon share/tiles/small.gif ${PN}.gif
	make_desktop_entry xmahjongg "Xmahjongg" /usr/share/pixmaps/${PN}.gif
	prepgamesdirs
}
