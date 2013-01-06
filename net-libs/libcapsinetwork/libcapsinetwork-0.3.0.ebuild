# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libcapsinetwork/libcapsinetwork-0.3.0.ebuild,v 1.2 2008/05/04 09:57:41 drac Exp $

inherit autotools eutils flag-o-matic

DESCRIPTION="C++ network library to allow fast development of server daemon processes"
HOMEPAGE="http://unixcode.org/libcapsinetwork"
SRC_URI="http://unixcode.org/downloads/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ppc sparc x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc43.patch \
		"${FILESDIR}"/${P}-parallel.patch \
		"${FILESDIR}"/${P}-64bit.patch
	eautoreconf
}

src_compile() {
	filter-flags -fomit-frame-pointer
	econf
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README TODO
}
