# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/thc-ipv6/thc-ipv6-2.0.ebuild,v 1.1 2012/10/12 06:13:02 xmw Exp $

EAPI=4

inherit eutils toolchain-funcs

DESCRIPTION="complete tool set to attack the inherent protocol weaknesses of IPV6 and ICMP6"
HOMEPAGE="http://freeworld.thc.org/thc-ipv6/"
SRC_URI="http://freeworld.thc.org/releases/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-libs/libpcap
	dev-libs/openssl"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-Makefile.patch
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" STRIP="true" install
	dodoc CHANGES HOWTO-INJECT README
}
