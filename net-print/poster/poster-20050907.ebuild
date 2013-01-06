# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/poster/poster-20050907.ebuild,v 1.1 2006/08/31 01:20:48 genstef Exp $

inherit toolchain-funcs

DESCRIPTION="small utility for making a poster from an EPS file or a one-page PS document"
SRC_URI="mirror://kde/printing/${P}.tar.bz2"
HOMEPAGE="http://printing.kde.org/downloads"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
IUSE=""

src_compile(){
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} ${PN}.c -lm -o ${PN} || die "compile failed"
}

src_install() {
	dobin ${PN}
	doman ${PN}.1
	dodoc README ChangeLog
}
