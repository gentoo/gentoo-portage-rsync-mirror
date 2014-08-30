# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/pork/pork-0.99.8.1.ebuild,v 1.17 2014/08/30 12:29:14 mgorny Exp $

DESCRIPTION="Console based AIM client that looks like ircII"
HOMEPAGE="http://dev.ojnk.net/"
SRC_URI="mirror://sourceforge/ojnk/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~mips ppc sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="perl"

DEPEND="perl? ( dev-lang/perl )
	sys-libs/ncurses"

src_compile() {
	local myconf=""
	econf $(use_enable perl) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die

	doman doc/pork.1 || die
	insinto /usr/share/pork/examples
	doins examples/blist.txt || die

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README STYLE TODO QUICK_START || die
}

pkg_postinst() {
	elog "Be aware that the syntax for IRC connections has"
	elog "changed. Read ${HOMEPAGE}/stuff/pork.news"
	elog "for details."
}
