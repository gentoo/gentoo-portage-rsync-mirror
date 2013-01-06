# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/librsync/librsync-0.9.7-r2.ebuild,v 1.7 2012/09/09 15:45:20 armin76 Exp $

EAPI="3"

inherit eutils libtool autotools

DESCRIPTION="Flexible remote checksum-based differencing"
HOMEPAGE="http://librsync.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ia64 ppc ppc64 s390 sh sparc x86 ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="static-libs"

RDEPEND="dev-libs/popt"

src_prepare() {
	# Bug #142945
	epatch "${FILESDIR}"/${P}-huge-files.patch

	# Bug #185600 (was elibtoolize; extended to eautoreconf for interix)
	eautoreconf # need new libtool for interix
	epunt_cxx
}

src_configure() {
	econf --enable-shared $(use_enable static-libs static) || die
}

src_install () {
	emake DESTDIR="${D}" install || die
	dodoc NEWS AUTHORS THANKS README TODO
	if ! use static-libs; then
		rm -f "${ED}"/usr/lib/librsync.la || die
	fi
}
