# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/pcapfix/pcapfix-0.7.ebuild,v 1.2 2012/10/23 17:20:05 mr_bones_ Exp $

EAPI=4

DESCRIPTION="pcapfix tries to repair your broken pcap files by fixing the global
header and recovering the packets by searching und guessing the packet headers."
HOMEPAGE="http://f00l.de/pcapfix/"
SRC_URI="http://f00l.de/pcapfix/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	sed -e 's/gcc/$(CC) $(CFLAGS)/g' -i Makefile
}

src_install() {
	doman pcapfix.1
	dobin pcapfix
	dodoc README TODO Changelog
}
