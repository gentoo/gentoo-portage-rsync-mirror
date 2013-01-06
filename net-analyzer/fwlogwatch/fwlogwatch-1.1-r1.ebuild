# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/fwlogwatch/fwlogwatch-1.1-r1.ebuild,v 1.1 2009/08/25 22:37:06 jer Exp $

EAPI="2"

inherit toolchain-funcs eutils

DESCRIPTION="A packet filter and firewall log analyzer"
HOMEPAGE="http://fwlogwatch.inside-security.de/"
SRC_URI="http://www.kybs.de/boris/sw/${P}.tar.bz2"

KEYWORDS="~amd64 ~ppc ~sparc ~x86"
LICENSE="GPL-1"
SLOT="0"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}/${P}-make.patch"
}

src_compile() {
	tc-export CC
	emake || die "emake failed"
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
	doins contrib
	insinto /etc

	doins fwlogwatch.config fwlogwatch.template

	dodoc AUTHORS ChangeLog CREDITS README
	doman fwlogwatch.8
}
