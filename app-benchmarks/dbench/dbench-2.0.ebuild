# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/dbench/dbench-2.0.ebuild,v 1.22 2010/11/10 19:03:35 patrick Exp $

DESCRIPTION="Popular filesystem benchmark"
SRC_URI="ftp://samba.org/pub/tridge/dbench/${P}.tar.gz"
HOMEPAGE="ftp://samba.org/pub/tridge/dbench/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 hppa ppc ppc64 sparc x86"
IUSE=""
DEPEND="sys-apps/sed"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "s:-O2 -Wall:${CFLAGS}:g" Makefile
}

src_compile() {
	emake
}

src_install() {
	dobin dbench tbench tbench_srv
	dodoc README results.txt
	insinto /usr/share/dbench
	doins client_plain.txt client_oplocks.txt
	doman dbench.1
}

pkg_postinst() {
	elog "You can find the client_*.txt file in ${ROOT}usr/share/dbench."
}
