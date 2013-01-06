# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/wayv/wayv-0.3-r2.ebuild,v 1.3 2012/11/18 18:54:08 ago Exp $

EAPI="2"

inherit toolchain-funcs

DESCRIPTION="Wayv is hand-writing/gesturing recognition software for X"
HOMEPAGE="http://www.stressbunny.com/wayv"
SRC_URI="http://www.stressbunny.com/gimme/wayv/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXtst"
DEPEND="${RDEPEND}
	x11-proto/inputproto
	x11-proto/xproto"

src_prepare() {
	sed -i src/Makefile* \
		-e 's| = -Wall -O2| += |g' || die "sed failed"
}

src_configure() {
	tc-export CC
	econf || die "econf failed"
}

src_install() {
	einstall || die
	cd doc
	einstall || die
	dodoc HOWTO*
}
