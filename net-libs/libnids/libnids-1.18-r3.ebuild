# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnids/libnids-1.18-r3.ebuild,v 1.1 2014/03/19 15:47:03 jer Exp $

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="an implementation of an E-component of Network Intrusion Detection System"
HOMEPAGE="http://www.packetfactory.net/Projects/libnids/"
SRC_URI="http://www.packetfactory.net/Projects/libnids/dist/${P/_}.tar.gz"

LICENSE="GPL-2"
SLOT="1.1"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="static-libs"

DEPEND="
	net-libs/libpcap
	>=net-libs/libnet-1.1.0-r3
"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-chksum.c-ebx.patch \
		"${FILESDIR}"/${P}-elif.patch \
		"${FILESDIR}"/${PN}-1.24-ldflags.patch \
		"${FILESDIR}"/${PN}-1.24-static-libs.patch
}

src_configure() {
	tc-export AR
	econf --enable-shared
}

src_compile() {
	emake shared $(usex static-libs static '')
}

src_install() {
	local tgt
	for tgt in _installshared $(usex static-libs _install ''); do
		emake install_prefix="${D}" ${tgt}
	done

	dodoc CHANGES CREDITS MISC README
}
