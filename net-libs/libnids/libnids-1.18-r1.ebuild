# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnids/libnids-1.18-r1.ebuild,v 1.7 2012/03/10 16:32:49 ranger Exp $

EAPI="2"

inherit eutils

DESCRIPTION="an implementation of an E-component of Network Intrusion Detection System"
HOMEPAGE="http://www.packetfactory.net/Projects/libnids/"
SRC_URI="http://www.packetfactory.net/Projects/libnids/dist/${P/_}.tar.gz"

LICENSE="GPL-2"
SLOT="1.1"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="net-libs/libpcap
	>=net-libs/libnet-1.1.0-r3"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-chksum.c-ebx.patch \
		"${FILESDIR}"/${P}-elif.patch \
		"${FILESDIR}"/${PN}-1.24-ldflags.patch
}

src_configure() {
	econf --enable-shared || die "econf failed"
}

src_install() {
	emake install_prefix="${D}" install || die "emake install failed"
	dodoc CHANGES CREDITS MISC README
}
