# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/idnkit/idnkit-1.0-r2.ebuild,v 1.9 2012/03/02 20:58:22 ranger Exp $

EAPI="4"

inherit autotools eutils fixheadtails

DESCRIPTION="Toolkit for Internationalized Domain Names (IDN)"
HOMEPAGE="http://www.nic.ad.jp/ja/idn/idnkit/download/"
SRC_URI="http://www.nic.ad.jp/ja/idn/idnkit/download/sources/${P}-src.tar.gz"

LICENSE="JNIC"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="static-libs"

DEPEND="virtual/libiconv"

S=${WORKDIR}/${P}-src

src_prepare() {
	ht_fix_all
	# Bug 263135, old broken libtool bundled
	rm -f aclocal.m4 || die "rm failed"
	epatch "${FILESDIR}/${P}-autotools.patch"
	eautoreconf
}

src_configure() {
	myconf=""
	if has_version dev-libs/libiconv; then
		myconf="--with-iconv"
	fi
	econf $(use_enable static-libs static) ${myconf}
}

src_install() {
	default
	if ! use static-libs; then
		rm -f "${D}"/usr/lib*/lib*.la
	fi
	dodoc ChangeLog DISTFILES NEWS README README.ja
}
