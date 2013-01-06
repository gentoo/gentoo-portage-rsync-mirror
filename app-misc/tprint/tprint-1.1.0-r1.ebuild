# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tprint/tprint-1.1.0-r1.ebuild,v 1.1 2010/09/28 19:41:29 jer Exp $

EAPI="2"

inherit toolchain-funcs

DESCRIPTION="Transparent Print Utility for terminals"
HOMEPAGE="http://sourceforge.net/projects/tprint/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

src_prepare() {
	sed -i Makefile \
		-e 's:cc:$(CC):g' \
		-e 's:-g -O2:$(CFLAGS) $(LDFLAGS):g' \
		|| die "sed failed"
}

src_compile() {
	emake CC=$(tc-getCC) || die "emake failed"
}

src_install() {
	dodir /etc/tprint
	insinto /etc/tprint
	doins tprint.conf
	exeinto /usr/bin
	doexe tprint || die "doexe failed"

	dodoc INSTALL README
}
