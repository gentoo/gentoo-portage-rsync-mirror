# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/zoom/zoom-1.1.4.ebuild,v 1.3 2010/01/06 07:05:30 josejx Exp $

inherit games

DESCRIPTION="A fast, clean, modern Z-code interpreter for X"
HOMEPAGE="http://www.logicalshift.co.uk/unix/zoom/"
SRC_URI="http://www.logicalshift.co.uk/unix/zoom/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

RDEPEND="x11-libs/libSM
	x11-libs/libXft
	media-libs/fontconfig
	>=media-libs/t1lib-5
	media-libs/libpng"
DEPEND="${RDEPEND}
	dev-lang/perl
	x11-proto/xextproto"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
	dohtml -r manual/*
	prepgamesdirs
}
