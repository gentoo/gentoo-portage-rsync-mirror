# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/raddump/raddump-0.2.1.ebuild,v 1.2 2007/05/12 04:58:13 robbat2 Exp $

inherit autotools

DESCRIPTION="raddump interprets captured RADIUS packets to print a timestamp, packet length, RADIUS packet type, source and destination hosts and ports, and included attribute names and values for each packet."
HOMEPAGE="http://sourceforge.net/projects/raddump/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND=">=net-analyzer/tcpdump-3.8.3-r1"

src_unpack() {
	unpack ${A}
	cd ${S}
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS README TODO ChangeLog
}
