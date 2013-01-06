# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/hunt/hunt-1.5-r1.ebuild,v 1.3 2012/01/15 15:37:03 phajdan.jr Exp $

EAPI="2"

inherit toolchain-funcs

DESCRIPTION="tool for checking well known weaknesses in the TCP/IP protocol"
HOMEPAGE="http://lin.fsid.cvut.cz/~kra/index.html"
SRC_URI="http://lin.fsid.cvut.cz/~kra/hunt/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

src_prepare() {
cp -av Makefile{,.orig}
	sed -i Makefile \
		-e 's:^CFLAGS=:CFLAGS += -I.:g' \
		-e '/^LDFLAGS=/d' \
		-e 's:${LDFLAGS}:$(LDFLAGS):g' \
		-e 's:-O2 -g::' \
		|| die "sed Makefile"
}

src_compile() {
	emake CC=$(tc-getCC) || die "emake"
}

src_install() {
	dobin hunt
	doman man/hunt.1
	dodoc CHANGES README* TODO tpsetup/transproxy
}
