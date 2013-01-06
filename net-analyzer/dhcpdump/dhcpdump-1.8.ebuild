# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/dhcpdump/dhcpdump-1.8.ebuild,v 1.2 2011/07/21 01:50:53 jer Exp $

inherit eutils toolchain-funcs

DESCRIPTION="DHCP Packet Analyzer/tcpdump postprocessor"
HOMEPAGE="http://www.mavetju.org/unix/general.php"
SRC_URI="http://www.mavetju.org/download/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

CDEPEND="net-libs/libpcap"
DEPEND="dev-lang/perl"
RDEPEND="${CDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-Makefile.patch
	epatch "${FILESDIR}"/${P}-debian.patch
}

src_compile() {
	emake CC=$(tc-getCC) || die "emake failed"
}

src_install () {
	dobin ${PN}
	doman ${PN}.8
	dodoc CHANGES CONTACT
}
