# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vpncwatch/vpncwatch-1.7.ebuild,v 1.2 2011/10/07 17:23:06 jlec Exp $

EAPI=2

inherit eutils toolchain-funcs

DESCRIPTION="A keepalive daemon for vpnc on Linux systems"
HOMEPAGE="http://github.com/dcantrell/vpncwatch/"
SRC_URI="http://github.com/downloads/dcantrell/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-misc/vpnc"

src_prepare() {
	epatch \
		"${FILESDIR}/${P}-gcc4.3.patch" \
		"${FILESDIR}/${P}-literal.patch" \
		"${FILESDIR}/${P}-Makefile.patch"
	tc-export CC
}

src_install() {
	dobin ${PN} || die "failed to install ${PN}"
	dodoc README ChangeLog AUTHORS || die "doc install failed"
}
