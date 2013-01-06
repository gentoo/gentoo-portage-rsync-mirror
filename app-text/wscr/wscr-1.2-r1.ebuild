# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/wscr/wscr-1.2-r1.ebuild,v 1.7 2012/03/19 19:01:46 armin76 Exp $

inherit toolchain-funcs

DESCRIPTION="A Lightweight and Fast Anagram Solver"
HOMEPAGE="http://www.gentoo.org"
SRC_URI="ftp://hood.sjfn.nb.ca/pub/eddie/${P}.tar.gz"
LICENSE="public-domain"
SLOT="0"

KEYWORDS="amd64 ~mips ppc x86"
IUSE=""
RDEPEND="sys-apps/miscfiles"

src_compile() {
	sed -i 's#"/usr/dict/words";#"/usr/share/dict/words";#' wscr.h
	emake CC="$(tc-getCC)" FLAGS="${CFLAGS} ${LDFLAGS}" || die
}

src_install() {
	dobin wscr || die "dobin failed"
	doman wscr.6
	dodoc README
}
