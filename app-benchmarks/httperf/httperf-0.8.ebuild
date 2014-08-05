# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/httperf/httperf-0.8.ebuild,v 1.13 2014/08/05 07:59:56 patrick Exp $

WANT_AUTOCONF="2.1"

inherit eutils autotools toolchain-funcs

DESCRIPTION="A tool from HP for measuring web server performance"
HOMEPAGE="http://www.hpl.hp.com/research/linux/httperf/index.php"
SRC_URI="ftp://ftp.hpl.hp.com/pub/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~mips x86"
IUSE="debug ssl"

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-optional-ssl.diff
	epatch "${FILESDIR}"/${P}-respect-DESTDIR.diff

	eautoconf || die "autoconf failed"
}

src_compile() {
	econf --bindir=/usr/bin \
		$(use_enable debug) \
		$(use_enable ssl) \
		|| die "econf failed"

	emake CC=$(tc-getCC) -j1 || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}
