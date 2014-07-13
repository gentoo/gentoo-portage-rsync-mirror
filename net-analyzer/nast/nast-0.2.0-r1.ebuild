# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nast/nast-0.2.0-r1.ebuild,v 1.3 2014/07/13 14:28:50 jer Exp $

EAPI=5

inherit autotools eutils

DESCRIPTION="NAST - Network Analyzer Sniffer Tool"
HOMEPAGE="http://nast.berlios.de/"
SRC_URI="mirror://berlios/nast/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 x86"
IUSE="ncurses"

RDEPEND="
	>=net-libs/libnet-1.1.1
	net-libs/libpcap
	ncurses? ( >=sys-libs/ncurses-5.4 )
"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.patch
	eautoreconf
}

src_compile() {
	emake CFLAGS="${CFLAGS}"
}

src_install() {
	dosbin nast
	doman nast.8
	dodoc AUTHORS BUGS CREDITS ChangeLog NCURSES_README README TODO
}
