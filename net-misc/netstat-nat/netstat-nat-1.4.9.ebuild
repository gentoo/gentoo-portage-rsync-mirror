# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netstat-nat/netstat-nat-1.4.9.ebuild,v 1.6 2012/05/21 19:14:33 xarthisius Exp $

inherit autotools eutils

DESCRIPTION="Display NAT connections"
HOMEPAGE="http://tweegy.demon.nl/projects/netstat-nat/index.html"
SRC_URI="http://tweegy.demon.nl/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}"/${PN}-1.4.10-install.patch
	eautoreconf
}
src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
