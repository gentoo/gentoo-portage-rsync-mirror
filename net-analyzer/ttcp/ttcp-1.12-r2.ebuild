# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ttcp/ttcp-1.12-r2.ebuild,v 1.4 2013/01/31 23:04:56 ago Exp $

EAPI="4"

inherit toolchain-funcs

DESCRIPTION="Tool to test TCP and UDP throughput"
HOMEPAGE="
	http://ftp.arl.mil/~mike/ttcp.html
	http://www.netcore.fi/pekkas/linux/ipv6/
"
SRC_URI="
	mirror://gentoo/${P}.tar.bz2
	http://www.netcore.fi/pekkas/linux/ipv6/${PN}.c
"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 ~hppa ~mips ppc ~sparc x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

DEPEND=""

src_unpack() {
	default
	cp "${DISTDIR}/${PN}.c" "${S}/${PN}.c" || die "mv failed"
}

src_compile() {
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} -o "${PN}" "${PN}".c || die "compile failed"
}

src_install() {
	dobin "${PN}"
	newman sgi-"${PN}".1 "${PN}".1
}
