# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/sslscan/sslscan-1.8.2.ebuild,v 1.4 2012/08/06 06:22:09 ssuominen Exp $

EAPI=4

inherit eutils toolchain-funcs

DESCRIPTION="Fast SSL port scanner"
HOMEPAGE="https://www.titania-security.com/labs/sslscan"
SRC_URI="mirror://sourceforge/sslscan/${P}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/openssl:0"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-makefile.patch
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	dobin sslscan
	doman sslscan.1
	dodoc Changelog
}
