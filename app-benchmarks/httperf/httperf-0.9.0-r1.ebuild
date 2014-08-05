# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/httperf/httperf-0.9.0-r1.ebuild,v 1.5 2014/08/05 07:59:56 patrick Exp $

EAPI=2

inherit eutils autotools toolchain-funcs

DESCRIPTION="A tool from HP for measuring web server performance"
HOMEPAGE="http://code.google.com/p/httperf/"
SRC_URI="http://httperf.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~mips x86"
IUSE="debug"

DEPEND="dev-libs/openssl"
RDEPEND="dev-libs/openssl"

src_prepare() {
	eautoconf || die "autoconf failed"
}
src_configure() {
	econf --bindir=/usr/bin \
		$(use_enable debug) \
		|| die "econf failed"
}
src_compile() {
	emake CC=$(tc-getCC) -j1 || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}
