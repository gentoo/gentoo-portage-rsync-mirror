# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/dhcpdump/dhcpdump-1.8.ebuild,v 1.3 2013/07/01 13:44:47 zx2c4 Exp $

inherit eutils toolchain-funcs

DESCRIPTION="DHCP Packet Analyzer/tcpdump postprocessor"
HOMEPAGE="http://www.mavetju.org/unix/general.php"
SRC_URI="http://www.mavetju.org/download/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~mips"
IUSE=""

CDEPEND="net-libs/libpcap"
DEPEND="dev-lang/perl"
RDEPEND="${CDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-Makefile.patch
	epatch "${FILESDIR}"/${P}-debian.patch
	epatch "${FILESDIR}"/${P}-endianness.patch
}

src_compile() {
	emake CC=$(tc-getCC) || die "emake failed"
}

src_install () {
	dobin ${PN}
	doman ${PN}.8
	dodoc CHANGES CONTACT
}
