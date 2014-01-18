# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/serf/serf-1.2.1.ebuild,v 1.12 2014/01/18 09:24:57 vapier Exp $

EAPI="5"

inherit autotools eutils

DESCRIPTION="HTTP client library"
HOMEPAGE="http://code.google.com/p/serf/"
SRC_URI="http://serf.googlecode.com/files/${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="1"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~ppc-macos ~x64-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
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
	default
	find "${ED}" "(" -name "*.a" -o -name "*.la" ")" -delete
}
