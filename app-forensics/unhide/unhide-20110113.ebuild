# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/unhide/unhide-20110113.ebuild,v 1.1 2011/12/01 01:56:25 blueness Exp $

EAPI="4"

inherit toolchain-funcs

DESCRIPTION="A forensic tool to find hidden processes and TCP/UDP ports by rootkits/LKMs or other technique."
HOMEPAGE="http://www.unhide-forensics.info"
SRC_URI="mirror://sourceforge/${PN}/files/${P}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	$(tc-getCC) --static ${CFLAGS} ${LDFLAGS} -o ${PN}-tcp ${PN}-tcp.c
	$(tc-getCC) --static -pthread ${CFLAGS} ${LDFLAGS} -o ${PN}-linux26 ${PN}-linux26.c
}

src_install() {
	dobin ${PN}-tcp
	newbin ${PN}-linux26 ${PN}
	dodoc changelog README.txt TODO
	doman man/unhide.8 man/unhide-tcp.8
	has "fr" ${LINGUAS} && newman man/fr/unhide.8 unhide.fr.8
	has "es" ${LINGUAS} && newman man/es/unhide.8 unhide.es.8
}
