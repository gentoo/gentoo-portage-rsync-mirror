# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netstat-nat/netstat-nat-1.4.10.ebuild,v 1.7 2012/04/15 04:04:58 heroxbd Exp $

EAPI="2"

inherit autotools eutils

DESCRIPTION="Display NAT connections"
HOMEPAGE="http://tweegy.nl/projects/netstat-nat/index.html"
SRC_URI="http://tweegy.nl/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ppc sparc x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-install.patch
	eautoreconf
}
src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
}
