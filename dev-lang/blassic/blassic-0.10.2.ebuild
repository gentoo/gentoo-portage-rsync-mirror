# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/blassic/blassic-0.10.2.ebuild,v 1.8 2014/07/04 08:29:33 mr_bones_ Exp $

EAPI=5
inherit eutils

DESCRIPTION="classic Basic interpreter"
HOMEPAGE="http://blassic.org"
SRC_URI="http://blassic.org/bin/${P}.tgz"

LICENSE="GPL-2"
KEYWORDS="~amd64 hppa ppc x86 ~x86-linux ~ppc-macos ~x86-macos"
SLOT="0"
IUSE="X"

RDEPEND="sys-libs/ncurses
	X? ( x11-libs/libICE x11-libs/libX11 x11-libs/libSM )"
DEPEND="${RDEPEND}
	X? ( x11-proto/xproto )"

src_configure() {
	econf \
		--disable-svgalib \
		$(use_with X x)
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS NEWS README THANKS TODO
}
