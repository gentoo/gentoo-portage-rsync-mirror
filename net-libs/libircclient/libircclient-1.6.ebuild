# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libircclient/libircclient-1.6.ebuild,v 1.4 2012/05/20 09:41:00 ago Exp $

EAPI=4
inherit autotools eutils

DESCRIPTION="Small but powerful library implementing the client-server IRC protocol"
HOMEPAGE="http://www.ulduzsoft.com/libircclient/"
SRC_URI="mirror://sourceforge/libircclient/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc ipv6 ssl threads"

DEPEND="ssl? ( dev-libs/openssl )"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-build.patch \
		"${FILESDIR}"/${P}-include.patch
	eautoconf
}

src_configure() {
	econf \
		$(use_enable threads) \
		$(use_enable ipv6) \
		$(use_enable ssl openssl) \
		$(use_enable ssl threads)
}

src_compile() {
	emake -C src
}

src_install() {
	insinto /usr/include/libircclient
	doins include/*.h
	dolib src/libircclient.a

	dodoc Changelog THANKS
	if use doc ; then
		doman doc/man/man3/*
		dohtml doc/html/*
	fi
}
