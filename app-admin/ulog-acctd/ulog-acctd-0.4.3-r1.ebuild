# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/ulog-acctd/ulog-acctd-0.4.3-r1.ebuild,v 1.4 2012/02/24 19:28:51 ranger Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="ULOG-based accounting daemon with flexible log-format"
SRC_URI="http://alioth.debian.org/download.php/949/${PN}_${PV}.orig.tar.gz"
HOMEPAGE="http://savannah.nongnu.org/projects/ulog-acctd/ http://alioth.debian.org/projects/pkg-ulog-acctd"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="net-firewall/iptables"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/${P}.orig

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.4.2-gcc2.patch
	sed -i src/Makefile \
		-e 's| -o | $(LDFLAGS)&|g' \
		-e '/^DEBUG/d' \
		|| die "sed src/Makefile"
}

src_compile() {
	emake CC=$(tc-getCC) -C src || die "emake src"
	emake -C doc || die "emake doc"
}

src_install() {
	dosbin src/ulog-acctd

	insinto /etc/
	doins src/ulog-acctd.conf

	doman doc/ulog-acctd.8
	doinfo doc/ulog-acctd.info

	## install contrib-dir in /usr/share/doc/${P}:
	docinto contrib/pg_load
	dodoc contrib/pg_load/*

	docinto contrib/ulog-acctd2mrtg
	dodoc contrib/ulog-acctd2mrtg/*

	keepdir /var/log/ulog-acctd
	doinitd "${FILESDIR}"/init.d/ulog-acctd
}

pkg_postinst() {
	elog "ulog-acctd get's it's packages via ULOG-targets in your iptables-rules."
}
