# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ttcp/ttcp-1.12-r1.ebuild,v 1.3 2012/10/12 10:16:50 pinkbyte Exp $

EAPI="2"

inherit toolchain-funcs eutils

IUSE=""
DESCRIPTION="Tool to test TCP and UDP throughput"
HOMEPAGE="http://ftp.arl.mil/~mike/ttcp.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~mips ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos"

DEPEND=""
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}"/ttcp-1.12-amd64.patch
}

src_compile() {
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} -o ttcp sgi-ttcp.c || die "compile failed"
}

src_install() {
	dobin ttcp
	newman sgi-ttcp.1 ttcp.1
}
