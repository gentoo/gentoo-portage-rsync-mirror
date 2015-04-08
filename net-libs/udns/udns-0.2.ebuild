# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/udns/udns-0.2.ebuild,v 1.1 2012/09/05 15:51:52 jer Exp $

EAPI="4"
inherit eutils multilib toolchain-funcs

DESCRIPTION="Async-capable DNS stub resolver library"
HOMEPAGE="http://www.corpit.ru/mjt/udns.html"
SRC_URI="http://www.corpit.ru/mjt/udns/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="ipv6 static"

# Yes, this doesn't depend on any other library beside "system" set
DEPEND=""
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}/${PN}-0.1-respect-LDFLAGS.patch"
}

src_configure() {
	# Uses non-standard configure script, econf doesn't work
	CC=$(tc-getCC) ./configure $(use_enable ipv6) || die "Configure failed"
}

src_compile() {
	emake sharedlib
}

src_install() {
	dolib.so libudns.so.0 || die "dolib.so failed"
	dosym libudns.so.0 "/usr/$(get_libdir)/libudns.so" || die "dosym failed"

	insinto /usr/include
	doins udns.h

	doman udns.3
	dodoc NEWS NOTES TODO
}
