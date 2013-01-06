# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/bwping/bwping-1.4.ebuild,v 1.3 2012/01/28 15:04:00 phajdan.jr Exp $

EAPI="2"

inherit autotools

DESCRIPTION="A tool to measure bandwidth and RTT between two hosts using ICMP"
HOMEPAGE="http://bwping.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~sparc x86 ~x86-fbsd"
IUSE=""

src_prepare() {
	eautoreconf
}

src_install () {
	dosbin bwping || die "dosbin failed"
	doman  bwping.8 || die "doman failed"
	dodoc  ChangeLog README || die "dodoc failed"
}
