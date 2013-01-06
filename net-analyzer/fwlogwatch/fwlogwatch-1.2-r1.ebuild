# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/fwlogwatch/fwlogwatch-1.2-r1.ebuild,v 1.2 2011/08/03 14:32:31 jer Exp $

EAPI="4"

inherit eutils toolchain-funcs

DESCRIPTION="A packet filter and firewall log analyzer"
HOMEPAGE="http://fwlogwatch.inside-security.de/"
SRC_URI="${HOMEPAGE}sw/${P}.tar.bz2"

KEYWORDS="~amd64 ~ppc ~sparc ~x86"
LICENSE="GPL-1"
SLOT="0"
IUSE=""

src_prepare() {
	epatch \
		"${FILESDIR}"/${PN}-1.1-make.patch \
		"${FILESDIR}"/${PN}-1.2-overflow.patch
}

src_compile() {
	tc-export CC
	default
}

src_install() {
	dosbin fwlogwatch
	dosbin contrib/fwlw_notify
	dosbin contrib/fwlw_respond
	dodir /usr/share/fwlogwatch/contrib
	insinto /usr/share/fwlogwatch/contrib

	doins contrib/fwlogsummary.cgi
	doins contrib/fwlogsummary_small.cgi
	doins contrib/fwlogwatch.php

	insinto /etc
	doins fwlogwatch.config

	dodoc AUTHORS ChangeLog CREDITS README
	doman fwlogwatch.8
}
