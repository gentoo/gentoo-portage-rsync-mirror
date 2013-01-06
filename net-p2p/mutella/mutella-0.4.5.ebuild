# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/mutella/mutella-0.4.5.ebuild,v 1.10 2010/01/07 14:55:42 fauli Exp $

inherit eutils

DESCRIPTION="Text-mode gnutella client"
SRC_URI="mirror://sourceforge/mutella/${P}.tar.gz"
HOMEPAGE="http://mutella.sourceforge.net/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ppc x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="debug"
DEPEND="sys-libs/readline"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc41.patch
	epatch "${FILESDIR}"/${P}-gcc43.patch
	epatch "${FILESDIR}"/${P}-glibc-2.10.patch
}

src_compile() {
	econf --enable-optimization \
		`use_enable debug` || die "econf failed"
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog KNOWN-BUGS README TODO
}
