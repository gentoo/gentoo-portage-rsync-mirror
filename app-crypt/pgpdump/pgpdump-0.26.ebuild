# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/pgpdump/pgpdump-0.26.ebuild,v 1.6 2012/11/17 10:27:32 ulm Exp $

inherit toolchain-funcs

DESCRIPTION="A PGP packet visualizer"
HOMEPAGE="http://www.mew.org/~kazu/proj/pgpdump/"
SRC_URI="http://www.mew.org/~kazu/proj/pgpdump/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

DEPEND="sys-libs/zlib
	app-arch/bzip2"

src_compile() {
	econf || die
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die
}

src_install() {
	dobin pgpdump
	doman pgpdump.1

	dodoc CHANGES README
}
