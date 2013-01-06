# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/duhdraw/duhdraw-2.8.12.ebuild,v 1.11 2008/01/26 15:02:22 grobian Exp $

inherit toolchain-funcs eutils

DESCRIPTION="ASCII art editor"
HOMEPAGE="http://www.cs.helsinki.fi/u/penberg/duhdraw"
SRC_URI="http://www.wwco.com/~wls/opensource/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

DEPEND="sys-libs/ncurses"
RDEPEND=${DEPEND}

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-macos.patch
	epatch "${FILESDIR}"/${P}-prestrip.patch
}

src_compile() {
	emake CC="$(tc-getCC) ${CFLAGS}" || die "emake failed"
}

src_install() {
	dobin ansi ansitoc duhdraw || die
	dodoc CREDITS HISTORY TODO READ.ME
}
