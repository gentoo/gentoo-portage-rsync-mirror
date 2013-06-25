# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/fwlogwatch/fwlogwatch-1.3.ebuild,v 1.3 2013/06/25 11:41:00 ago Exp $

EAPI="4"

inherit eutils toolchain-funcs

DESCRIPTION="A packet filter and firewall log analyzer"
HOMEPAGE="http://fwlogwatch.inside-security.de/"
SRC_URI="${HOMEPAGE}sw/${P}.tar.bz2"

KEYWORDS="amd64 ~ppc ~sparc x86"
LICENSE="GPL-1"
SLOT="0"
IUSE="adns nls zlib"

RDEPEND="
	adns? ( net-libs/adns )
	zlib? ( sys-libs/zlib )
"
DEPEND="
	${RDEPEND}
	sys-devel/flex
"

src_configure() {
	if use adns; then
		sed -i Makefile -e '/^LIBS/ s|#-ladns |-ladns #|g' || die
	fi
	if ! use zlib; then
		sed -i Makefile -e '/^LIBS/ s|-lz||g' || die
	fi
}

src_compile() {
	local myconf=$(
		use adns && echo -n "-DHAVE_ADNS "
		use nls && echo -n "-DHAVE_GETTEXT "
		use zlib && echo -n "-DHAVE_ZLIB "
	)
	emake \
		CC=$(tc-getCC) \
		CFLAGS="${CFLAGS} ${myconf}" \
		LDFLAGS="${LDFLAGS}"
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
