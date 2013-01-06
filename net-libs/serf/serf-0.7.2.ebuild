# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/serf/serf-0.7.2.ebuild,v 1.9 2011/07/17 09:02:10 xarthisius Exp $

EAPI="3"

inherit autotools eutils

DESCRIPTION="HTTP client library"
HOMEPAGE="http://code.google.com/p/serf/"
SRC_URI="http://serf.googlecode.com/files/${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd ~ppc-macos ~x64-macos"
IUSE=""

DEPEND="dev-libs/apr:1
	dev-libs/apr-util:1
	dev-libs/openssl
	sys-libs/zlib"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-0.3.1-disable-unneeded-linking.patch"
	eautoreconf
}

src_configure() {
	econf \
		--with-apr="${EPREFIX}/usr/bin/apr-1-config" \
		--with-apr-util="${EPREFIX}/usr/bin/apu-1-config" \
		--with-openssl="${EPREFIX}/usr"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc CHANGES README
}
