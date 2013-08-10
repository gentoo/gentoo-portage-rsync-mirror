# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/pgpdump/pgpdump-0.28.ebuild,v 1.1 2013/08/10 21:52:29 mrueg Exp $

EAPI=5
inherit toolchain-funcs

DESCRIPTION="A PGP packet visualizer"
HOMEPAGE="http://www.mew.org/~kazu/proj/pgpdump/"
SRC_URI="http://www.mew.org/~kazu/proj/pgpdump/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="sys-libs/zlib
	app-arch/bzip2"
RDEPEND="${DEPEND}"

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}"
}

src_install() {
	dobin pgpdump
	doman pgpdump.1
	dodoc CHANGES README.md
}
