# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnids/libnids-1.18-r2.ebuild,v 1.5 2013/06/29 18:27:09 ago Exp $

EAPI="4"

inherit eutils

DESCRIPTION="an implementation of an E-component of Network Intrusion Detection System"
HOMEPAGE="http://www.packetfactory.net/Projects/libnids/"
SRC_URI="http://www.packetfactory.net/Projects/libnids/dist/${P/_}.tar.gz"

LICENSE="GPL-2"
SLOT="1.1"
KEYWORDS="amd64 ppc x86"
IUSE="static-libs"

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
	econf --enable-shared
}

src_install() {
	emake install_prefix="${D}" install
	use static-libs || rm -f "${D}"/usr/lib*/libnids.a
	dodoc CHANGES CREDITS MISC README
}
