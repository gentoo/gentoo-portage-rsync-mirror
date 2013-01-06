# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcptrace/tcptrace-6.6.7.ebuild,v 1.9 2010/07/26 22:56:17 jer Exp $

EAPI="2"

inherit flag-o-matic

IUSE=""

DESCRIPTION="A Tool for analyzing network packet dumps"
HOMEPAGE="http://www.tcptrace.org/"
SRC_URI="http://www.tcptrace.org/download/${P}.tar.gz
	http://www.tcptrace.org/download/old/6.6/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ppc64 x86"

DEPEND="net-libs/libpcap"

src_prepare() {
	append-flags -D_BSD_SOURCE
}

src_install() {
	dobin tcptrace xpl2gpl

	newman tcptrace.man tcptrace.1
	dodoc CHANGES COPYRIGHT FAQ README* THANKS WWW
}

pkg_postinst() {
	elog
	elog "Note: tcptrace outputs its graphs in the xpl (xplot)"
	elog "format. Since xplot is unavailable, you will have to"
	elog "use the included xpl2gpl utility to convert it to"
	elog "the gnuplot format."
	elog
}
