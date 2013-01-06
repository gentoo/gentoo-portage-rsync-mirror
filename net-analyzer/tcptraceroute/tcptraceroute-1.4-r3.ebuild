# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcptraceroute/tcptraceroute-1.4-r3.ebuild,v 1.9 2006/02/17 16:19:40 jokey Exp $

inherit eutils flag-o-matic

DESCRIPTION="tcptraceroute is a traceroute implementation using TCP packets"
HOMEPAGE="http://michael.toren.net/code/tcptraceroute/"
SRC_URI="http://michael.toren.net/code/tcptraceroute/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE=""

DEPEND="net-libs/libpcap
	<net-libs/libnet-1.1
	>=net-libs/libnet-1.0.2a-r3"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch
	epatch ${FILESDIR}/${PV}-libnet-1.0.patch
}

src_compile() {
	append-ldflags -Wl,-z,now

	make CFLAGS="${CFLAGS}" || die
}

src_install() {
	dosbin tcptraceroute
	fperms 4710 /usr/sbin/tcptraceroute
	fowners root:wheel /usr/sbin/tcptraceroute
	doman tcptraceroute.8
	dodoc examples.txt COPYING README changelog
	dohtml -r ./
}
