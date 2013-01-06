# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ssldump/ssldump-0.9-r1.ebuild,v 1.7 2011/12/09 16:15:55 jer Exp $

EAPI=2
inherit autotools eutils

MY_P=${PN}-0.9b3

DESCRIPTION="A Tool for network monitoring and data acquisition"
HOMEPAGE="http://www.rtfm.com/ssldump/"
SRC_URI="http://www.rtfm.com/ssldump/${MY_P}.tar.gz"

LICENSE="openssl"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="ssl"

RDEPEND="net-libs/libpcap
	ssl? ( >=dev-libs/openssl-1 )"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-libpcap-header.patch \
		"${FILESDIR}"/${P}-configure-dylib.patch \
		"${FILESDIR}"/${P}-openssl-0.9.8.compile-fix.patch \
		"${FILESDIR}"/${P}-DLT_LINUX_SLL.patch

	sed -i configure.in -e 's|libpcap.a|libpcap.so|g' || die

	eautoreconf
}

src_configure() {
	local myconf
	use ssl || myconf="--without-openssl"

	econf ${myconf}
}

src_install() {
	dosbin ssldump || die
	doman ssldump.1 || die
	dodoc ChangeLog CREDITS README
}
