# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/dbench/dbench-3.04.ebuild,v 1.10 2009/09/13 22:20:15 patrick Exp $

DESCRIPTION="Popular filesystem benchmark"
SRC_URI="ftp://ftp.samba.org/pub/tridge/dbench/${P}.tar.gz"
HOMEPAGE="http://samba.org/ftp/tridge/dbench/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 hppa ppc ppc64 sparc ~x86"
IUSE=""

src_install() {
	dobin dbench tbench tbench_srv
	dodoc README INSTALL
	doman dbench.1
	insinto /usr/share/dbench
	doins client.txt
}

pkg_postinst() {
	elog "You can find the client.txt file in ${ROOT}usr/share/dbench."
}
